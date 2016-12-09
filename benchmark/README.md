# To compile all benchmarks
First, bsp and hardware projects need to be created:
```sh
../scripts/create_bsps.sh
```
Then, an SDK project for each benchmark folder can be created and compiled:
```sh
../scripts/create_project.sh
```
# To compile a specific banchmark
If not done previously, you may need first to create a Xilinx SDK project for the corresponding benchmark by running 
```sh
../scripts/create_project.sh <path of the benchmark, e.g. copy>
```
Then, you may compile the benchmark by runnging a tcl script
```sh
../scripts/compile.sh <path of the benchmark, e.g. copy>
```

# Instructions for running a benchnark from terminal:
+ After a successful compilation of the corresponding benchmark, open a terminal and run the following command:
```sh
open_sdk.sh <path of the benchmark, e.g. copy>
```
This will open the Xilinx command line tool (xsct).
+ Program a bitstream by sourcing the following tcl script in xsct
```sh
source program_bitstream.tcl
```
+ Download the elf file by running
```sh
source download_elf.tcl
```
