//===-- lib/comparesf2.c - Single-precision comparisons -----------*- C -*-===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is dual licensed under the MIT and the University of Illinois Open
// Source Licenses. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
//
// This file implements the following soft-fp_t comparison routines:
//
//   __eqsf2   __gesf2   __unordsf2
//   __lesf2   __gtsf2
//   __ltsf2
//   __nesf2
//
// The semantics of the routines grouped in each column are identical, so there
// is a single implementation for each, and wrappers to provide the other names.
//
// The main routines behave as follows:
//
//   __lesf2(a,b) returns -1 if a < b
//                         0 if a == b
//                         1 if a > b
//                         1 if either a or b is NaN
//
//   __gesf2(a,b) returns -1 if a < b
//                         0 if a == b
//                         1 if a > b
//                        -1 if either a or b is NaN
//
//   __unordsf2(a,b) returns 0 if both a and b are numbers
//                           1 if either a or b is NaN
//
// Note that __lesf2( ) and __gesf2( ) are identical except in their handling of
// NaN values.
//
//===----------------------------------------------------------------------===//
#include "fp_lib.h"
inline enum LE_RESULT __less(float a, float b) {
  const int aInt = toRep(a);
  const int bInt = toRep(b);
  const unsigned aAbs = aInt & absMask;
  const unsigned bAbs = bInt & absMask;
  unsigned res;
    
  // If at least one of a and b is positive, we get the same result comparing
  // a and b as signed integers as we would with a fp_ting-point compare.
  unsigned res_one_positive;
  res_one_positive = aInt<bInt ? LE_LESS:LE_GREATER;
  // Otherwise, both are negative, so we need to flip the sense of the
  // comparison to get the correct result.  (This assumes a twos- or ones-
  // complement integer representation; if integers are represented in a
  // sign-magnitude representation, then this flip is incorrect).
  unsigned res_two_negatives;
  res_two_negatives = aInt>bInt ? LE_LESS:LE_GREATER;

  res = (aInt&bInt) >= 0 ? res_one_positive:res_two_negatives;
  res = aInt==bInt ? LE_EQUAL:res;
    
  // If a and b are both zeros, they are equal.
  res = (aAbs | bAbs) == 0 ? LE_EQUAL:res;

  // If either a or b is NaN, they are unordered.
  unsigned resNaN = aAbs > infRep || bAbs > infRep;
  res = resNaN ? LE_UNORDERED:res;
  
  return res;
}
inline enum GE_RESULT __greater(float a, float b) {
  const int aInt = toRep(a);
  const int bInt = toRep(b);
  const unsigned aAbs = aInt & absMask;
  const unsigned bAbs = bInt & absMask;
  unsigned res;

  unsigned res_one_positive;
  res_one_positive = aInt<bInt ? GE_LESS:GE_GREATER;
  unsigned res_two_negatives;
  res_two_negatives = aInt>bInt ? GE_LESS:GE_GREATER;

  res = (aInt&bInt) >= 0 ? res_one_positive:res_two_negatives;
  res = aInt==bInt ? GE_EQUAL:res;
    
  res = (aAbs | bAbs) == 0 ? GE_EQUAL:res;
  unsigned resNaN = aAbs > infRep || bAbs > infRep;
  res = resNaN ? GE_UNORDERED:res;

  return res;
}
enum LE_RESULT __eqsf2(float a, float b) {
  return __less(a,b);
}
enum LE_RESULT __nesf2(float a, float b) {
  return __less(a,b);
}
enum LE_RESULT __lesf2(float a, float b) {
  return __less(a,b);
}
enum LE_RESULT __ltsf2(float a, float b) {
  return __less(a,b);
}
enum GE_RESULT __gesf2(float a, float b) {
  return __greater(a, b);
}
enum GE_RESULT __gtsf2(float a, float b) {
  return __greater(a, b);
}
int __unordsf2(float a, float b) {
    const unsigned aAbs = toRep(a) & absMask;
    const unsigned bAbs = toRep(b) & absMask;
    return aAbs > infRep || bAbs > infRep;
}

