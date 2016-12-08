if {$argc != 2} {puts "wrong number of arguments to create_sdk_project.tcl"; puts $argc;exit 1}
set name [lindex $argv 0]
set path [lindex $argv 1]
#Set SDK workspace path
setws $path
# Create the HW project
createhw -name .$name\_hw -hwspec V2.hdf
# Create  BSP projects
createbsp -name .$name\_bsp -hwproject .$name\_hw -proc ps7_cortexa9_0 -os standalone
# Build bsp
projects -build -type bsp -name .$name\_bsp
