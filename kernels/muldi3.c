/* ===-- muldi3.c - Implement __muldi3 -------------------------------------===
 *
 *                     The LLVM Compiler Infrastructure
 *
 * This file is dual licensed under the MIT and the University of Illinois Open
 * Source Licenses. See LICENSE.TXT for details.
 *
 * ===----------------------------------------------------------------------===
 *
 * This file implements __muldi3 for the compiler_rt library.
 *
 * ===----------------------------------------------------------------------===
 */

// This file is originally a part of the compiler-RT/LLVM compiler infrastructure
// and it has been edited to fit to FGPU

long __muldsi3(unsigned a, unsigned b)
{
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

/* Returns: a * b */

long __muldi3(long a, long b) {
  dwords x;
  x.all = a;
  dwords y;
  y.all = b;
  dwords r;
  r.all = __muldsi3(x.s.low, y.s.low);
  r.s.high += x.s.high * y.s.low + x.s.low * y.s.high;
  return r.all;
}
