# To compile an existing banchmark
You may use Xilinx SDK or run the tcl script
```sh
../scripts/compile.sh <path of the benchmark, e.g. copy>
```

# To run an applications from terminal:
+ After a successful compilation, open a terminal and run the following command:
```sh
open_sdk.sh <path of the benchmark, e.g. copy>
```
This will open the Xilinx command line tool (xsct).
+ Program a bitstream:
```sh
source program_bitstream.tcl
```
An appropriate bitstream will be downloaded. You may change it by editing the script file.
+ Download and run the elf file by executing
```sh
source download_elf.tcl
```
# Power Measurement
The power consumption of a running application can be measured. 
+ The project `power_measurement` can run of the second ARM core while the FGPU project is running on the first core.
+ The measurement can performed by:
..* Enabling this feature in the `main.cpp` file of the benchmark that you may measure its power consumption
```c++
  const unsigned sync_power_measurement = 1;
```
--* Compile the benchmark:
```sh
../scripts/compile.sh <path of the benchmark, e.g. copy>
```
..* Sourcing the script `measure_power.tcl` in xsct. It will program both ARM cores accordingly:
```sh
source measure_power.tcl
```
