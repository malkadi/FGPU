//===-- lib/divsf3.c - Single-precision division ------------------*- C -*-===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is dual licensed under the MIT and the University of Illinois Open
// Source Licenses. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
//
// This file implements single-precision soft-float division
// with the IEEE-754 default rounding (to nearest, ties to even).
//
// For simplicity, this implementation currently flushes denormals to zero.
// It should be a fairly straightforward exercise to implement gradual
// underflow with correct rounding.
//
//===----------------------------------------------------------------------===//

// This file is originally a part of the compiler-RT/LLVM compiler infrastructure
// and it has been edited to fit to FGPU

#include "fp_lib.h"

inline unsigned __muldsi3_high(unsigned a, unsigned b) {
  const int bits_in_word_2 = 16;
  const unsigned lower_mask = (unsigned)~0 >> bits_in_word_2;
  unsigned ll = ((a & lower_mask) * (b & lower_mask));
  unsigned lh = (a >> bits_in_word_2) * (b & lower_mask);
  unsigned hl = (b >> bits_in_word_2) * (a & lower_mask);
  unsigned hh = (a >> bits_in_word_2) * (b >> bits_in_word_2);
  unsigned res = ll >> bits_in_word_2;
  res += lh & lower_mask;
  res += hl & lower_mask;
  res >>= bits_in_word_2;
  res += lh >> bits_in_word_2;
  res += hl >> bits_in_word_2;
  res += hh;
  return res;
}
inline long muldsi3(unsigned a, unsigned b) {
  dwords r;
  const int bits_in_word_2 = 16;
  const unsigned lower_mask = (unsigned)~0 >> bits_in_word_2;
  r.s.low = (a & lower_mask) * (b & lower_mask);
  unsigned t = r.s.low >> bits_in_word_2;
  r.s.low &= lower_mask;
  t += (a >> bits_in_word_2) * (b & lower_mask);
  r.s.low += (t & lower_mask) << bits_in_word_2;
  r.s.high = t >> bits_in_word_2;
  t = r.s.low >> bits_in_word_2;
  r.s.low &= lower_mask;
  t += (b >> bits_in_word_2) * (a & lower_mask);
  r.s.low += (t & lower_mask) << bits_in_word_2;
  r.s.high += t >> bits_in_word_2;
  r.s.high += (a >> bits_in_word_2) * (b >> bits_in_word_2);
  return r.all;
}
float __divsf3(float a, float b) {
  const unsigned int aExponent = toRep(a) >> significandBits & maxExponent;
  const unsigned int bExponent = toRep(b) >> significandBits & maxExponent;
  const unsigned quotientSign = (toRep(a) ^ toRep(b)) & signBit;
  
  unsigned aSignificand = toRep(a) & significandMask;
  unsigned bSignificand = toRep(b) & significandMask;
  int scale = 0;
  
  // Detect if a or b is zero, denormal, infinity, or NaN.
  if (aExponent-1U >= maxExponent-1U || bExponent-1U >= maxExponent-1U) {
    
    const unsigned aAbs = toRep(a) & absMask;
    const unsigned bAbs = toRep(b) & absMask;
    
    // NaN / anything = qNaN
    if (aAbs > infRep) return fromRep(toRep(a) | quietBit);
    // anything / NaN = qNaN
    if (bAbs > infRep) return fromRep(toRep(b) | quietBit);
    
    if (aAbs == infRep) {
      // infinity / infinity = NaN
      if (bAbs == infRep) return fromRep(qnanRep);
      // infinity / anything else = +/- infinity
      else return fromRep(aAbs | quotientSign);
    }
    
    // anything else / infinity = +/- 0
    if (bAbs == infRep) return fromRep(quotientSign);
    
    if (!aAbs) {
      // zero / zero = NaN
      if (!bAbs) return fromRep(qnanRep);
      // zero / anything else = +/- zero
      else return fromRep(quotientSign);
    }
    // anything else / zero = +/- infinity
    if (!bAbs) return fromRep(infRep | quotientSign);
    
    // one or both of a or b is denormal, the other (if applicable) is a
    // normal number.  Renormalize one or both of a and b, and set scale to
    // include the necessary exponent adjustment.
    if (aAbs < implicitBit) scale += normalize(&aSignificand);
    if (bAbs < implicitBit) scale -= normalize(&bSignificand);

    /* // NaN / anything = qNaN or  anything / NaN = qNaN */
    /* unsigned resNaN = aAbs > infRep || bAbs > infRep; */
    /* // infinity / infinity = NaN */
    /* resNaN = resNaN || (aAbs==infRep && bAbs==infRep); */
    /* // zero / zero = NaN */
    /* resNaN = resNaN || (!aAbs && !bAbs); */
    /* if (resNaN) return fromRep(qnanRep); */
    /*  */
    /* // infinity / anything else = +/- infinity */
    /* // anything else / zero = +/- infinity */
    /* unsigned resInf = aAbs==infRep || !bAbs; */
    /* if (resInf) return fromRep(infRep | quotientSign); */
    /*  */
    /* // anything else / infinity = +/- 0 */
    /* // zero / anything else = +/- zero */
    /* unsigned resZero = bAbs==infRep || !aAbs; */
    /* if (resZero) return fromRep(quotientSign); */
    /*  */
    /* // one or both of a or b is denormal, the other (if applicable) is a */
    /* // normal number.  Renormalize one or both of a and b, and set scale to */
    /* // include the necessary exponent adjustment. */
    /* if (aAbs < implicitBit) scale += normalize(&aSignificand); */
    /* if (bAbs < implicitBit) scale -= normalize(&bSignificand); */
  }


  // Or in the implicit significand bit.  (If we fell through from the
  // denormal path it was already set by normalize( ), but setting it twice
  // won't hurt anything.)
  aSignificand |= implicitBit;
  bSignificand |= implicitBit;
  int quotientExponent = aExponent - bExponent + scale;
  
  
  // Align the significand of b as a Q31 fixed-point number in the range
  // [1, 2.0) and get a Q32 approximate reciprocal using a small minimax
  // polynomial approximation: reciprocal = 3/4 + 1/sqrt(2) - b/2.  This
  // is accurate to about 3.5 binary digits.
  unsigned q31b = bSignificand << 8;
  unsigned reciprocal = ((unsigned)0x7504f333) - q31b;
  
  // Now refine the reciprocal estimate using a Newton-Raphson iteration:
  //
  //     x1 = x0 * (2 - x0 * b)
  //
  // This doubles the number of correct binary digits in the approximation
  // with each iteration, so after three iterations, we have about 28 binary
  // digits of accuracy.
  unsigned correction;
  
  /* unsigned correctionOverflow; */
  /* correction = -(__muldsi3_high(reciprocal, q31b)); */
  /* correctionOverflow = correction & 0x80000000 ? reciprocal:0; */
  /* reciprocal = __muldsi3_high(reciprocal, 2*correction) + correctionOverflow; */
  /* correction = -(__muldsi3_high(reciprocal, q31b)); */
  /* correctionOverflow = correction & 0x80000000 ? reciprocal:0; */
  /* reciprocal = __muldsi3_high(reciprocal, 2*correction) + correctionOverflow; */
  /* correction = -(__muldsi3_high(reciprocal, q31b)); */
  /* correctionOverflow = correction & 0x80000000 ? reciprocal:0; */
  /* reciprocal = __muldsi3_high(reciprocal, 2*correction) + correctionOverflow; */
  
  correction = -(__muldsi3_high(reciprocal, q31b));
  reciprocal = muldsi3(reciprocal, correction) >> 31;
  correction = -(__muldsi3_high(reciprocal, q31b));
  reciprocal = muldsi3(reciprocal, correction) >> 31;
  correction = -(__muldsi3_high(reciprocal, q31b));
  reciprocal = muldsi3(reciprocal, correction) >> 31;
  
  // Exhaustive testing shows that the error in reciprocal after three steps
  // is in the interval [-0x1.f58108p-31, 0x1.d0e48cp-29], in line with our
  // expectations.  We bump the reciprocal by a tiny value to force the error
  // to be strictly positive (in the range [0x1.4fdfp-37,0x1.287246p-29], to
  // be specific).  This also causes 1/1 to give a sensible approximation
  // instead of zero (due to overflow).
  reciprocal -= 2;
  
  // The numerical reciprocal is accurate to within 2^-28, lies in the
  // interval [0x1.000000eep-1, 0x1.fffffffcp-1], and is strictly smaller
  // than the true reciprocal of b.  Multiplying a by this reciprocal thus
  // gives a numerical q = a/b in Q24 with the following properties:
  //
  //    1. q < a/b
  //    2. q is in the interval [0x1.000000eep-1, 0x1.fffffffcp0)
  //    3. the error in q is at most 2^-24 + 2^-27 -- the 2^24 term comes
  //       from the fact that we truncate the product, and the 2^27 term
  //       is the error in the reciprocal of b scaled by the maximum
  //       possible value of a.  As a consequence of this error bound,
  //       either q or nextafter(q) is the correctly rounded 
  unsigned quotient = __muldsi3_high(reciprocal, aSignificand << 1);
  // unsigned quotient = (unsigned long)reciprocal*(aSignificand << 1) >> 32;
  
  // Two cases: quotient is in [0.5, 1.0) or quotient is in [1.0, 2.0).
  // In either case, we are going to compute a residual of the form
  //
  //     r = a - q*b
  //
  // We know from the construction of q that r satisfies:
  //
  //     0 <= r < ulp(q)*b
  // 
  // if r is greater than 1/2 ulp(q)*b, then q rounds up.  Otherwise, we
  // already have the correct result.  The exact halfway case cannot occur.
  // We also take this time to right shift quotient if it falls in the [1,2)
  // range and adjust the exponent accordingly.
  unsigned residual;

  unsigned decreaseExponent = quotient < (implicitBit << 1);
  quotientExponent -= decreaseExponent?1:0;
  quotient >>= decreaseExponent?0:1;
  residual = aSignificand << (decreaseExponent?24:23);
  residual -= quotient * bSignificand;

  /* if (quotient < (implicitBit << 1)) { */
  /*   residual = (aSignificand << 24) - quotient * bSignificand; */
  /*   quotientExponent--; */
  /* } else { */
  /*   quotient >>= 1; */
  /*   residual = (aSignificand << 23) - quotient * bSignificand; */
  /* } */

  const int writtenExponent = quotientExponent + exponentBias;
  
  if (writtenExponent >= maxExponent) {
    // If we have overflowed the exponent, return infinity.
    return fromRep(infRep | quotientSign);
  }
  
  else if (writtenExponent < 1) {
    // Flush denormals to zero.      
    const bool round = (residual << 1) > bSignificand;
    unsigned shift = 1-(unsigned)writtenExponent;
    shift = shift > 30 ? 31:shift;
    unsigned res = (quotient+round) >> shift;
    res |= quotientSign;
    return fromRep(res);
  }
  
  else {
    const bool round = (residual << 1) > bSignificand;
    // Clear the implicit bit
    unsigned absResult = quotient & significandMask;
    // Insert the exponent
    absResult |= (unsigned)writtenExponent << significandBits;
    // Round
    absResult += round;
    // cout << "quotient is " << quotient << "(0x" << std::hex << quotient << ")" << endl;
    // Insert the sign and return
    return fromRep(absResult | quotientSign);
  }
}
