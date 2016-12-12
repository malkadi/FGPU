# Setup instructions
+ Make sure to edit the `set_paths.sh` script to refer to your Vivado installation
+ Create and compile the needed hardware and bsp projects by executing
```sh
./create_bsps.sh
```
+ Create the SDK projects for all applications in the `benchmark` folder and compile them
```sh
./create_project.sh
```
