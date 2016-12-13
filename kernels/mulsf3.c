//===-- lib/mulsf3.c - Single-precision multiplication ------------*- C -*-===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is dual licensed under the MIT and the University of Illinois Open
// Source Licenses. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
//
// This file implements single-precision soft-float multiplication
// with the IEEE-754 default rounding (to nearest, ties to even).
//
//===----------------------------------------------------------------------===//
// This file is originally a part of the compiler-RT/LLVM compiler infrastructure
// and it has been edited to fit to FGPU

#include "fp_lib.h"
#include "muldi3.c"

float __mulsf3(float a, float b) {
  const unsigned int aExponent = toRep(a) >> significandBits & maxExponent;
  const unsigned int bExponent = toRep(b) >> significandBits & maxExponent;
  const unsigned productSign = (toRep(a) ^ toRep(b)) & signBit;

  unsigned aSignificand = toRep(a) & significandMask;
  unsigned bSignificand = toRep(b) & significandMask;
  int scale = 0;

  // Detect if a or b is zero, denormal, infinity, or NaN.
  if (aExponent-1U >= maxExponent-1U || bExponent-1U >= maxExponent-1U) {
    const unsigned aAbs = toRep(a) & absMask;
    const unsigned bAbs = toRep(b) & absMask;
    
    unsigned resNaN = aAbs > infRep || bAbs > infRep;
    // NaN * anything = qNaN or anything * NaN = qNaN
    if (resNaN) return fromRep(qnanRep);

    unsigned resInf = aAbs==infRep || bAbs==infRep;
    // infinity * non-zero = +/- infinity
    // infinity * zero = NaN
    unsigned otherNumber = aAbs==infRep ? bAbs:aAbs;
    if (resInf) {
      resInf = otherNumber ? infRep|productSign:qnanRep;
      return fromRep(resInf);
    }

    // zero * anything = +/- zero or anything * zero = +/- zero
    const bool resZero = !aAbs || !bAbs;
    if(resZero) return fromRep(productSign);

    // one or both of a or b is denormal, the other (if applicable) is a
    // normal number.  Renormalize one or both of a and b, and set scale to
    // include the necessary exponent adjustment.
    if (aAbs < implicitBit) scale += normalize(&aSignificand);
    if (bAbs < implicitBit) scale += normalize(&bSignificand);
  }

  // Or in the implicit significand bit.  (If we fell through from the
  // denormal path it was already set by normalize( ), but setting it twice
  // won't hurt anything.)
  aSignificand |= implicitBit;
  bSignificand |= implicitBit;

  // Get the significand of a*b.  Before multiplying the significands, shift
  // one of them left to left-align it in the field.  Thus, the product will
  // have (exponentBits + 2) integral digits, all but two of which must be
  // zero.  Normalizing this result is just a conditional left-shift by one
  // and bumping the exponent accordingly.
  unsigned productHi, productLo;
  wideMultiply(aSignificand, bSignificand << exponentBits,
               &productHi, &productLo);

  int productExponent = aExponent + bExponent - exponentBias + scale;

  // Normalize the significand, adjust exponent if needed.
  unsigned hi = productHi << 1 | productLo >> (typeWidth - 1);
  unsigned lo = productLo << 1;
  unsigned cond = productHi & implicitBit;
  productExponent +=  cond ? 1:0;
  productHi = cond? productHi:hi;
  productLo = cond? productLo:lo;
  /* if (productHi & implicitBit) productExponent++; */
  /* else wideLeftShift(&productHi, &productLo, 1); */
    
  if (productExponent <= 0) {
    // Result is denormal before rounding
    //
    // If the result is so small that it just underflows to zero, return
    // a zero of the appropriate sign.  Mathematically there is no need to
    // handle this case separately, but we make it a special case to
    // simplify the shift logic.
    const unsigned int shift = 1 - (unsigned int)productExponent;
    if (shift >= typeWidth) return fromRep(productSign);

    // Otherwise, shift the significand of the result so that the round
    // bit is the high bit of productLo.
    wideRightShiftWithSticky(&productHi, &productLo, shift);
  }
  else {
    // Result is normal before rounding; insert the exponent.
    productHi &= significandMask;
    productHi |= (unsigned)productExponent << significandBits;
  }

  // Insert the sign of the result:
  productHi |= productSign;

  // Final rounding.  The final result may overflow to infinity, or underflow
  // to zero, but those are the correct results in those cases.  We use the
  // default IEEE-754 round-to-nearest, ties-to-even rounding mode.
  productHi += (productLo > signBit);
  productHi += productLo==signBit? productHi&1:0;
  
  // If we have overflowed the type, return +/- infinity.
  productHi = productExponent >= maxExponent ? infRep|productSign:productHi;
  
  return fromRep(productHi);
}
