| Name                                  |#CUs | Sub-int | Atomic  | #AXIs | #TAGM | Floats              | #Statins  | LMEM/Work-item  |Cache Banks  | Freq.(MHz)  |
|---------------------------------------|-----|---------|---------|-------|-------|---------------------|-----------|-----------------|-------------|-------------|
|V2_8CUs                                |8    |No       |None     |1      |8      |None                 |4          |16               |8->1         |250          |
|V2_8CUs_2_CACHE_WORDS                  |8    |No       |None     |1      |8      |None                 |4          |16               |8->2         |250          |
|V2_8CUs_4_CACHE_WORDS                  |8    |No       |None     |1      |8      |None                 |4          |16               |8->4         |250          |
|V2_8CUs_2AXI                           |8    |No       |None     |2      |8      |None                 |4          |16               |8->1         |240          |
|V2_8CUs_2AXI_2CACHE_WORDS              |8    |No       |None     |2      |8      |None                 |4          |16               |8->2         |240          |
|V2_8CUs_2AXI_4CACHE_WORDS              |8    |No       |None     |2      |8      |None                 |4          |16               |8->4         |240          |
|V2_8CUs_4AXI                           |8    |No       |None     |4      |8      |None                 |4          |16               |8->1         |235          | 
|V2_8CUs_4AXI_2TAGM                     |8    |No       |None     |4      |16     |None                 |4          |16               |8->1         |205          | 
|V2_8CUs_6Stations                      |8    |No       |None     |1      |8      |None                 |6          |16               |8->1         |230          |
|V2_8CUs_6Stations_2AXI                 |8    |No       |None     |2      |8      |None                 |6          |16               |8->1         |235          |
|V2_8CUs_fdiv                           |8    |No       |None     |1      |8      |/                    |4          |0                |8->1         |225          |
|V2_8CUs_fdiv_LMEM                      |8    |No       |None     |1      |8      |/                    |4          |16               |8->1         |210          |
|V2_8CUs_fdiv_2AXI                      |8    |No       |None     |2      |8      |/                    |4          |0                |8->1         |215          |
|V2_8CUs_fdiv_fadd                      |8    |No       |None     |1      |8      |+,-,/                |3          |0                |8->1         |215          |
|V2_8CUs_fadd                           |8    |No       |None     |1      |8      |+,-                  |4          |0                |8->1         |240          |
|V2_8CUs_fadd_2AXI                      |8    |No       |None     |2      |8      |+,-                  |4          |0                |8->1         |240          |
|V2_8CUs_fadd_fmul_2AXI                 |8    |No       |None     |2      |8      |+,-,\*               |4          |0                |8->1         |240          |
|V2_8CUs_fadd_fmul_2AXI_2CACHE_W        |8    |No       |None     |2      |8      |+,-,\*               |4          |0                |8->2         |235          |
|V2_8CUs_fadd_fmul_2AXI_4CACHE_W        |8    |No       |None     |2      |8      |+,-,\*               |4          |0                |8->4         |230          |
|V2_8CUs_fadd_fmul_2_CACHE_WORDS        |8    |No       |None     |1      |8      |+,-,\*               |4          |0                |8->2         |240          |
|V2_8CUs_fadd_fmul_4_CACHE_WORDS        |8    |No       |None     |1      |8      |+,-,\*               |4          |0                |8->4         |240          |
|V2_8CUs_fadd_fmul_fdiv                 |8    |No       |None     |1      |8      |+,-,\*,/             |3          |0                |4->1         |200          |
|V2_8CUs_fadd_fmul_fsqrt_2AXI           |8    |No       |None     |2      |8      |+,-,\*,fsqrt         |4          |16               |8->1         |200          |
|V2_8CUs_fadd_fmul_fsqrt_uitofp         |8    |No       |None     |1      |8      |+,-,\*,sqrt,uitofp   |3          |0                |8->1         |225          |
|V2_8CUs_fadd_fmul_fsqrt_uitofp_2AXI    |8    |No       |None     |2      |8      |+,-,\*,sqrt,uitofp   |3          |0                |4->1         |220          |
|V2_8CUs_fadd_fmul_LMEM                 |8    |No       |None     |1      |8      |+,-,\*               |4          |16               |8->1         |240          |
|V2_8CUs_fadd_fmul_LMEM_2AXI            |8    |No       |None     |2      |8      |+,-,\*               |4          |16               |8->1         |220          |
|V2_8CUs_fadd_fmul_LMEM_4_CACHE_W       |8    |No       |None     |1      |8      |+,-,\*               |4          |16               |8->4         |240          |
|V2_8CUs_fadd_fmul_LMEM_2_CACHE_W       |8    |No       |None     |1      |8      |+,-,\*               |4          |16               |8->2         |240          |
|V2_8CUs_fadd_fmul                      |8    |No       |None     |1      |8      |+,-,\*               |4          |0                |8->1         |240          |
|V2_8CUs_fadd_fslt                      |8    |No       |None     |1      |8      |+,-,slt              |4          |16               |8->1         |250          |
|V2_8CUs_fadd_fslt_4CACHE_W             |8    |No       |None     |1      |8      |+,-,slt              |4          |0                |8->4         |250          |
|V2_8CUs_fadd_fslt_2AXI                 |8    |No       |None     |2      |8      |+,-,slt              |4          |0                |8->1         |240          |
|V2_8CUs_fadd_fslt_2AXI_4CACHE_W        |8    |No       |None     |2      |8      |+,-,slt              |4          |0                |8->4         |240          |
|V2_8CUs_fmul_2AXI                      |8    |No       |None     |2      |8      |\*                   |4          |0                |8->1         |240          |
|V2_8CUs_fslt                           |8    |No       |None     |1      |8      |slt                  |4          |0                |8->1         |250          |
|V2_8CUs_fslt_2AXI                      |8    |No       |None     |2      |8      |slt                  |4          |0                |8->1         |240          |
|V2_8CUs_fslt_2CACHE_W                  |8    |No       |None     |1      |8      |+,-,\*               |4          |0                |8->2         |240          |
|V2_8CUs_fslt_4CACHE_W                  |8    |No       |None     |1      |8      |+,-,\*               |4          |0                |8->2         |240          |
|V2_8CUs_fslt_2AXI_2CACHE_W             |8    |No       |None     |2      |8      |+,-,\*               |4          |0                |8->2         |240          |
|V2_8CUs_fslt_2AXI_4CACHE_W             |8    |No       |None     |2      |8      |+,-,\*               |4          |0                |8->4         |240          |

|V2_4CUs                                |4    |No       |None     |1      |4      |None                 |4          |16               |4->1         |250          |
|V2_4CUs_2TAGM                          |4    |No       |None     |1      |8      |None                 |4          |16               |4->1         |250          |
|V2_4CUs_2AXI                           |4    |No       |None     |2      |4      |None                 |4          |16               |4->1         |250          |
|V2_4CUs_2AXI_2TAGM                     |4    |No       |None     |2      |8      |None                 |4          |16               |4->1         |250          |
|V2_4CUs_3Stations                      |4    |No       |None     |1      |4      |None                 |3          |16               |4->1         |250          |
|V2_4CUs_6Stations                      |4    |No       |None     |1      |4      |None                 |6          |16               |4->1         |250          |
|V2_4CUs_6Stations_2AXI                 |4    |No       |None     |2      |4      |None                 |6          |16               |4->1         |250          |
|V2_4CUs_6Stations_2TAGM                |4    |No       |None     |1      |8      |None                 |6          |16               |4->1         |250          |
|V2_4CUs_6Stations_8Banks               |4    |No       |None     |1      |4      |None                 |6          |16               |8->1         |250          |
|V2_4CUs_6Stations_2AXI_2TAGM           |4    |No       |None     |2      |8      |None                 |6          |16               |4->1         |250          |
|V2_4CUs_6Stations_8Banks_2TAGM         |4    |No       |None     |2      |8      |None                 |6          |16               |4->1         |250          |
|V2_4CUs_2Banks                         |4    |No       |None     |1      |4      |None                 |4          |16               |2->1         |250          |
|V2_4CUs_8Banks                         |4    |No       |None     |1      |4      |None                 |4          |16               |8->1         |250          |
|V2_4CUs_8Stations                      |4    |No       |None     |1      |4      |None                 |8          |16               |4->1         |250          |
|V2_4CUs_8Stations_2AXI                 |4    |No       |None     |2      |4      |None                 |8          |0                |4->1         |250          |
|V2_4CUs_8Stations_2TAGM                |4    |No       |None     |1      |8      |None                 |8          |16               |4->1         |250          |
|V2_4CUs_8Stations_2AXI_2TAGM           |4    |No       |None     |2      |8      |None                 |8          |16               |4->1         |250          |
|V2_4CUs_8Stations_2AXI_2CACHE_W        |4    |No       |None     |2      |4      |None                 |8          |16               |4->2         |250          |
|V2_4CUs_8Stations_2AXI_2TAGM_2CACHE_W  |4    |No       |None     |2      |8      |None                 |8          |16               |4->2         |250          |
|V2_4CUs_max                            |4    |Yes      |max,add  |2      |8      |+,-,\*,/,sqrt,uitofp |8          |32               |8            |210          |
|V2_4CUs_max_mem_cntrl                  |4    |No       |None     |2      |8      |None                 |8          |16               |8->1         |250          |
|V2_4CUs_float_max_mem                  |4    |No       |None     |2      |8      |+,-,\*,/,sqrt,uitofp,slt |8      |16               |8->1         |250          |
|V2_4CUs_fadd_fmul_fdiv_fsqrt_6_2_1_2   |4    |No       |None     |2      |4      |+,-,\*,/,sqrt        |6          |16               |4->2         |250          |
|V2_4CUs_fadd_fmul_fdiv_fsqrt_8_2_1_2   |4    |No       |None     |2      |4      |+,-,\*,/,sqrt        |8          |16               |4->2         |245          |
|V2_4CUs_fadd_fmul_fdiv_fsqrt_8_2_2_2   |4    |No       |None     |2      |8      |+,-,\*,/,sqrt        |8          |16               |4->2         |245          |
|V2_4CUs_fadd_fmul_fdiv_fsqrt_6_1_1_2   |4    |No       |None     |1      |4      |+,-,\*,/,sqrt        |6          |16               |4->2         |250          |
|V2_4CUs_all                            |4    |Yes      |max,add  |2      |4      |+,-,\*,/,sqrt,uitofp |4          |32               |8            |240          |
|V2_4CUs_float                          |4    |No       |No       |1      |4      |+,-,\*,/,sqrt,uitofp |4          |32               |8            |250          |
|V2_4CUs_float_2AXI                     |4    |No       |No       |2      |4      |+,-,\*,/,sqrt,uitofp |4          |32               |8            |250          |
|V2_4CUs_float_8ALUs_2AXI               |4    |No       |None     |2      |4      |+,-,\*,/,sqrt,uitofp |8          |32               |8            |250          |
|V2_4CUs_float_8ALUs                    |4    |No       |No       |1      |4      |+,-,\*,/,sqrt,uitofp |8          |32               |8            |240          |
|V2_4CUs_min                            |4    |No       |None     |1      |4      |None                 |4          |16               |8            |250          |
|V2_4CUs_fdiv_max                       |4    |No       |No       |2      |8      |/                    |8          |16               |8            |250          |
|V2_4CUs_fadd_fslt_max                  |4    |No       |No       |2      |8      |+,-,slt              |8          |16               |8            |240          |
|V2_4CUs_fadd_fmul_max                  |4    |No       |No       |2      |8      |+,-,slt              |8          |16               |8            |240          |
|V2_4CUs_fadd_fmul_fqsrt_uitofp_max     |4    |No       |No       |2      |8      |+,-,\*,/,sqrt,uitofp |8          |16               |8            |250          |

|V2_2CUs_float                          |2    |No       |None     |1      |2      |+,-,\*,/,sqrt,uitofp |4          |32               |8            |240          |
|V2_2CUs_float_2AXI_2TAGM               |2    |No       |None     |2      |4      |+,-,\*,/,sqrt,uitofp |4          |16               |8            |240          |
|V2_2CUs_min                            |2    |No       |None     |1      |2      |None                 |4          |16               |4            |250          |
|V2_2CUs_min_area                       |2    |No       |None     |1      |2      |None                 |4          |16               |4            |250          |

|V2_1CUs_min_area                       |1    |No       |None     |1      |2      |None                 |4          |16               |4            |250          |


@esit100
-t 0

-t 1

-t 2

-t 3



TO DO:
|V2_8CUs_SubInteger                     |8    |Yes      |None     |1      |8      |None                 |4          |32               |8            |245          |
|V2_8CUs_SubInteger_2AXI                |8    |Yes      |None     |2      |8      |None                 |4          |32               |8            |230          |
|V2_8CUs_SubInteger_2AXI_2TAGM          |8    |Yes      |None     |2      |16     |None                 |4          |32               |8            |220          |
|V2_8CUs_SubInteger_6ALUs               |8    |Yes      |None     |1      |8      |None                 |6          |32               |8            |230          |
|V2_8CUs_Atomic                         |8    |No       |max,add  |1      |8      |None                 |4          |16               |8            |245          |
|V2_8CUs_Atomic_2AXI                    |8    |No       |max,add  |2      |8      |None                 |4          |16               |8            |245          |
|V2_8CUs_Atomic_SubInteger              |8    |Yes      |max,add  |1      |8      |None                 |4          |16               |8            |230          |
|V2_8CUs_Atomic_4AXI                    |8    |No       |max,add  |4      |8      |None                 |4          |16               |8            |230          |
|V2_8CUs_Atomic_SubInteger_2AXI         |8    |Yes      |max,add  |2      |8      |None                 |4          |16               |8            |220          |

