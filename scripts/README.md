# Setup instructions

## LLVM Setup

By exeuting the script 'download_and_compile_llvm.sh' you can automatically:
+ Download and extract LLVM and clang source files (v3.7.1) 
+ Add the FGPU backend files to LLVM 
+ Compile LLVM to generate the FGPU compiler

## Create and compile Xilinx SDK projects
+ Make sure that the script `set_paths.sh` refers to your Vivado installation path (location of the *settings64.sh* script)
+ Create and compile the needed hardware and bsp projects for Xilinx SDK by executing
```sh
./create_bsps.sh
```
+ Create the Xilinx SDK projects for all applications in the `benchmark` folder and compile them by executing
```sh
./create_project.sh
```
Alternatively you may create and compile a single project, e.g.

```sh
./create_project.sh <path to benchmark folder, e.g. ../benchmark/copy>
```

## Remarks
+ The 'lscript*.ld' files are linker scripts needed to set the Xilinx SDK projects properly
