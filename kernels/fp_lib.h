//===-- lib/fp_lib.h - Floating-point utilities -------------------*- C -*-===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is dual licensed under the MIT and the University of Illinois Open
// Source Licenses. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
//
// This file is a configuration header for soft-float routines in compiler-rt.
// This file does not provide any part of the compiler-rt interface, but defines
// many useful constants and utility routines that are used in the
// implementation of the soft-float routines in compiler-rt.
//
// Assumes that float, double and long double correspond to the IEEE-754
// binary32, binary64 and binary 128 types, respectively, and that integer
// endianness matches floating point endianness on the target platform.
//
//===----------------------------------------------------------------------===//

// This file is originally a part of the compiler-RT/LLVM compiler infrastructure
// and it has been edited to fit to FGPU

#ifndef FP_LIB_HEADER
#define FP_LIB_HEADER

typedef union
{
  long all;
  struct
  {
    int high;
    unsigned low;
  }s;
} dwords;

inline int rep_clz(unsigned a) {
    return __builtin_clz(a);
}

// // 32x32 --> 64 bit multiply
inline void wideMultiply(unsigned a, unsigned b, unsigned *hi, unsigned *lo) {
    const unsigned long product = (unsigned long)a*b;
    *hi = product >> 32;
    *lo = product;
}

#define typeWidth       (sizeof(unsigned)*8)
#define significandBits 23
#define exponentBits    (typeWidth - significandBits - 1)
#define maxExponent     ((1 << exponentBits) - 1)
#define exponentBias    (maxExponent >> 1)

#define implicitBit     ((1) << significandBits)
#define significandMask (implicitBit - 1U)
#define signBit         ((1) << (significandBits + exponentBits))
#define absMask         (signBit - 1U)
#define exponentMask    (absMask ^ significandMask)
#define oneRep          ((unsigned)exponentBias << significandBits)
#define infRep          exponentMask
#define quietBit        (implicitBit >> 1)
#define qnanRep         (exponentMask | quietBit)

inline unsigned toRep(float x) {
    const union { float f; unsigned i; } rep = {.f = x};
    return rep.i;
}

inline float fromRep(unsigned x) {
    const union { float f; unsigned i; } rep = {.i = x};
    return rep.f;
}

inline int normalize(unsigned *significand) {
    const int shift = rep_clz(*significand) - rep_clz(implicitBit);
    *significand <<= shift;
    return 1 - shift;
}

inline void wideLeftShift(unsigned *hi, unsigned *lo, int count) {
    *hi = *hi << count | *lo >> (typeWidth - count);
    *lo = *lo << count;
}

inline void wideRightShiftWithSticky(unsigned *hi, unsigned *lo, unsigned int count) {
    if (count < typeWidth) {
        const bool sticky = *lo << (typeWidth - count);
        *lo = *hi << (typeWidth - count) | *lo >> count | sticky;
        *hi = *hi >> count;
    }
    else if (count < 2*typeWidth) {
        const bool sticky = *hi << (2*typeWidth - count) | *lo;
        *lo = *hi >> (count - typeWidth) | sticky;
        *hi = 0;
    } else {
        const bool sticky = *hi | *lo;
        *lo = sticky;
        *hi = 0;
    }
}


enum LE_RESULT {
    LE_LESS      = -1,
    LE_EQUAL     =  0,
    LE_GREATER   =  1,
    LE_UNORDERED =  1
};
enum GE_RESULT {
    GE_LESS      = -1,
    GE_EQUAL     =  0,
    GE_GREATER   =  1,
    GE_UNORDERED = -1   // Note: different from LE_UNORDERED
};
#endif // FP_LIB_HEADER
