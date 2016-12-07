if {$argc != 1} {puts "wrong number of arguments to create_sdk_project.tcl"; puts $argc;exit 1}
set name [lindex $argv 0]
#Set SDK workspace path
setws "../"
# Create application projects
createapp -name $name -hwproject FGPU_hw -bsp FGPU_bsp -proc ps7_cortexa9_0 -os standalone -lang c++ -app {Empty Application}
# Configure the projects for best optimization
configapp -app $name -set build-config {Release}
configapp -app $name -set compiler-optimization {Optimize most (-O3)}
# add math library for linking 
configapp -app $name -add libraries {m}
