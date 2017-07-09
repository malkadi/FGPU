Each subfolder is a standalone benchmark in the form of a Xilinx SDK project.
HLS & MicroBlaze benchmarks can be found in the `HLS` and `MicroBlaze` folders, respectively.

# To compile an existing application
You may use Xilinx SDK or run the tcl script
```sh
../scripts/compile.sh <application path, e.g. copy>
```

# To run an applications from terminal:
+ After a successful compilation, open a terminal and run the following command:
```sh
open_sdk.sh <application path, e.g. copy>
```
This will open the Xilinx command line tool (xsct). Then,
+ Program a bitstream:
```sh
source program_bitstream.tcl
```
This script will select an appropriate bitstream. You may change it by editing the script `program bitstream.sh`.
+ Download and run the elf file by executing
```sh
source download_elf.tcl
```
# Power Measurement
+ The project `power_measurement` should run of the second ARM core while the application project is running on the first core.
+ The measurement can performed by:
  + Enabling this feature in the `main.cpp` file of the application that you may measure its power consumption
  ```c++
    const unsigned sync_power_measurement = 1;
  ```
  + Compiling the application:
  ```sh
  ../scripts/compile.sh <application path, e.g. copy>
  ```
  + Sourcing the script `measure_power.tcl` in xsct. It will program both ARM cores accordingly:
  ```sh
  source measure_power.tcl
  ```
