//===-- lib/floatunsisf.c - uint -> single-precision conversion ---*- C -*-===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is dual licensed under the MIT and the University of Illinois Open
// Source Licenses. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
//
// This file implements unsigned integer to single-precision conversion for the
// compiler-rt library in the IEEE-754 default round-to-nearest, ties-to-even
// mode.
//
//===----------------------------------------------------------------------===//

#include "fp_lib.h"

float __floatunsisf(unsigned a) {
    
    const int aWidth = sizeof a * 8;
    
    // Handle zero as a special case to protect clz
    if (a == 0) return fromRep(0);
    
    // Exponent of (fp_t)a is the width of abs(a).
    const int exponent = (aWidth - 1) - __builtin_clz(a);
    unsigned result;
    
    // Shift a into the significand field, rounding if it is a right-shift
    if (exponent <= significandBits) {
        const int shift = significandBits - exponent;
        result = (unsigned)a << shift ^ implicitBit;
    } else {
        const int shift = exponent - significandBits;
        result = (unsigned)a >> shift ^ implicitBit;
        unsigned round = (unsigned)a << (typeWidth - shift);
        result += round>signBit;
        result += round==signBit ? result&1:0;
    }
    
    // Insert the exponent
    result += (unsigned)(exponent + exponentBias) << significandBits;
    return fromRep(result);
}
