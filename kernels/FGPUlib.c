#include"clctypes.h"
float sqrtf(float);
inline int get_group_id(const int dim){
  int res;
  __asm__ __volatile__("wgid %0, %1"
                          : "=r"(res)
                          : "I"(dim)
                        );
  return res;
}

inline int get_local_size(const int dim){
  int res;
  __asm__ __volatile__("wgsize %0, %1"
                          : "=r"(res)
                          : "I"(dim)
                        );
  return res;
}

inline int get_global_size(const int dim){
    int res;
    __asm__ __volatile__("size %0, %1"
                          :"=r"(res)
                          :"I"(dim)
                          );
    return res;
}

inline int get_global_id(const int dim){
    int index, tmp;
    __asm__ __volatile__("lid %0, %1"
                          :"=r"(tmp)
                          :"I"(dim)
                          );
    __asm__ __volatile__("wgoff %0, %1"
                          :"=r"(index)
                          :"I"(dim)
                          );
    return index+tmp;
}

inline int atomic_add(__global int *ptr, int val){
    int res=val;
    __asm__ __volatile__("aadd %0, %1, r0"
                          :"+r"(res)
                          :"r"(ptr)
                          );
    return res;
}

inline int atomic_max(__global int *ptr, int val){
    int res=val;
    __asm__ __volatile__("amax %0, %1, r0"
                          :"+r"(res)
                          :"r"(ptr)
                          );
    return res;
}


