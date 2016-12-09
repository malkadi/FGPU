# Setup instructions
+ Make sure to execute the Vivado setup script by editing the file set_paths.sh
+ Create and compile needed hardware and bsp projects 
```sh
./create_bsps.sh
```
+ Create SDK projects for all applications in the `benchmark` folder and compile them
```sh
./create_project.sh
```
