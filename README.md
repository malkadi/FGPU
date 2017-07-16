# FGPU
FGPU is a soft GPU-like architecture for FPGAs. It can be programmed using OpenCL and can be customized according to application needs.

The PYNQ interface of FGPU can be accessed on this [link](https://github.com/malkadi/FGPU_IPython).


## Repository Structure
+ Setup information is available in the `scripts` folder
+ Benchmarks are available in the `benchmark` folder
+ Source VHDL files for synthesis and simulation are located in the `RTL` folder
+ The LLVM backend files are located in the `llvm-3.7.1.src.fgpu` folder
+ All synthesis and implementation files and reports can be found in `HW`
+ `bitstreams` contains some pre-generated bitstreams
+ OpenCL kernels are located in the `kernels` folder

## Supported Boards
+ ZC706

## Puplications

 * [M. Al Kadi, B. Janssen, and M. Huebner, "FGPU: An SIMT-Architecture for FPGAs", FPGA ’16, Monterey, CA, USA](http://dl.acm.org/citation.cfm?id=2847273)
 * [M. Al Kadi and M. Huebner, "Integer computations with soft GPGPU on FPGAs," FPT'16, Xi'an, China](https://doi.org/10.1109/FPT.2016.7929185)
