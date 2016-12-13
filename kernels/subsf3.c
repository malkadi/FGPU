//===-- lib/addsf3.c - Single-precision addition ------------------*- C -*-===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is dual licensed under the MIT and the University of Illinois Open
// Source Licenses. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
//
// This file implements single-precision soft-float addition with the IEEE-754
// default rounding (to nearest, ties to even).
//
//===----------------------------------------------------------------------===//

// This file is originally a part of the compiler-RT/LLVM compiler infrastructure
// and it has been edited to fit to FGPU

#include "fp_lib.h"


float __subsf3(float a, float b) {
  b = fromRep(toRep(b) ^ signBit);
  unsigned aRep = toRep(a);
  unsigned bRep = toRep(b);
  const unsigned aAbs = aRep & absMask;
  const unsigned bAbs = bRep & absMask;

  // Detect if a or b is zero, infinity, or NaN.
  if (aAbs-1 >= infRep-1  || bAbs-1  >= infRep-1 ) {
    // NaN + anything = qNaN or anything + NaN = qNaN
    unsigned resNan = aAbs > infRep || bAbs > infRep;
    // +/-infinity + -/+infinity = qNaN
    resNan |= (aAbs == infRep) && ((toRep(a) ^ toRep(b)) == signBit);
    if (resNan) return fromRep(qnanRep);

    // +/-infinity + anything remaining = +/- infinity
    if (aAbs == infRep) return a;

    // anything remaining + +/-infinity = +/-infinity
    if (bAbs == infRep) return b;
    // zero + anything = anything
    if (!aAbs) {
      // but we need to get the sign right for zero + zero
      if (!bAbs) return fromRep(toRep(a) & toRep(b));
      else return b;
    }

    // anything + zero = anything
    if (!bAbs) return a;

  }

  // Swap a and b if necessary so that a has the larger absolute value.
  unsigned swap = bAbs>aAbs;
  unsigned minNum = swap?aRep:bRep;
  unsigned maxNum = swap?bRep:aRep;
  bRep = minNum;
  aRep = maxNum;


  // Extract the exponent and significand from the (possibly swapped) a and b.
  int aExponent = aRep >> significandBits & maxExponent;
  int bExponent = bRep >> significandBits & maxExponent;
  unsigned aSignificand = aRep & significandMask;
  unsigned bSignificand = bRep & significandMask;

  // Normalize any denormals, and adjust the exponent accordingly.
  if (aExponent == 0) aExponent = normalize(&aSignificand);
  if (bExponent == 0) bExponent = normalize(&bSignificand);

  // The sign of the result is the sign of the larger operand, a.  If they
  // have opposite signs, we are performing a subtraction; otherwise addition.
  const unsigned resultSign = aRep & signBit;
  const bool subtraction = (aRep ^ bRep) & signBit;

  // Shift the significands to give us round, guard and sticky, and or in the
  // implicit significand bit.  (If we fell through from the denormal path it
  // was already set by normalize( ), but setting it twice won't hurt
  // anything.)
  aSignificand = (aSignificand | implicitBit) << 3;
  bSignificand = (bSignificand | implicitBit) << 3;

  // Shift the significand of b by the difference in exponents, with a sticky
  // bottom bit to get rounding correct.
  const unsigned int align = aExponent - bExponent;

  /* const bool notZeroAlign = align!=0; */
  /* unsigned shiftBSignificand = align < typeWidth; */
  /* const bool sticky = bSignificand << (typeWidth - align); */
  /* bSignificand = notZeroAlign && shiftBSignificand ? (bSignificand>>align|sticky):bSignificand; */
  /* bSignificand = notZeroAlign && !shiftBSignificand ? 1:bSignificand; */
  if (align) {
    if (align < typeWidth) {
      const bool sticky = bSignificand << (typeWidth - align);
      bSignificand = bSignificand >> align | sticky;
    } else {
      bSignificand = 1; // sticky; b is known to be non-zero.
    }
  }
  if (subtraction) {
    aSignificand -= bSignificand;
    // If a == -b, return +zero.
    if (aSignificand == 0) return fromRep(0);

    // If partial cancellation occured, we need to left-shift the result
    // and adjust the exponent:
    if (aSignificand < implicitBit << 3) {
      const int shift = rep_clz(aSignificand) - rep_clz(implicitBit << 3);
      aSignificand <<= shift;
      aExponent -= shift;
    }
  }
  else /* addition */ {
    aSignificand += bSignificand;

    // If the addition carried up, we need to right-shift the result and
    // adjust the exponent:
    /* unsigned shift = aSignificand & implicitBit << 4; */
    /* const bool sticky = aSignificand & 1; */
    /* aSignificand = shift? (aSignificand>>1|sticky):aSignificand; */
    /* aExponent += shift? 1:0; */
    if (aSignificand & implicitBit << 4) {
      const bool sticky = aSignificand & 1;
      aSignificand = aSignificand >> 1 | sticky;
      aExponent += 1;
    }
  }

  // If we have overflowed the type, return +/- infinity:
  if (aExponent >= maxExponent) return fromRep(infRep | resultSign);

  if (aExponent <= 0) {
    // Result is denormal before rounding; the exponent is zero and we
    // need to shift the significand.
    const int shift = 1 - aExponent;
    const bool sticky = aSignificand << (typeWidth - shift);
    aSignificand = aSignificand >> shift | sticky;
    aExponent = 0;
  }

  // Low three bits are round, guard, and sticky.
  const int roundGuardSticky = aSignificand & 0x7;

  // Shift the significand into place, and mask off the implicit bit.
  unsigned result = aSignificand >> 3 & significandMask;

  // Insert the exponent and sign.
  result |= (unsigned)aExponent << significandBits;
  result |= resultSign;

  // Final rounding.  The result may overflow to infinity, but that is the
  // correct result in that case.
  /* result += roundGuardSticky > 0x4 ? 1:0; */
  /* result += roundGuardSticky == 0x4 ? result&1:0; */
  if (roundGuardSticky > 0x4) result++;
  if (roundGuardSticky == 0x4) result += result & 1;
  return fromRep(result);
}

