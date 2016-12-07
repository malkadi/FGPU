if {$argc != 1} {puts "wrong number of arguments to create_sdk_project.tcl"; puts $argc;exit 1}
#Set SDK workspace path
setws "../"
# Create the HW project
createhw -name MicroBlaze_hw -hwspec MicroBlaze.hdf
# Create  BSP projects
createbsp -name MicroBlaze_bsp -hwproject MicroBlaze_hw -proc microblaze_0 -os standalone
# Create application projects
createapp -name MicroBlaze -hwproject MicroBlaze_hw -bsp MicroBlaze_bsp -proc microblaze_0 -os standalone -lang c -app {Empty Application}
# Configure the projects for best optimization
configapp -app MicroBlaze -set build-config {Release}
configapp -app MicroBlaze -set compiler-optimization {Optimize most (-O3)}
# Build bsp
projects -build -type bsp -name MicroBlaze_bsp
