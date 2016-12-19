if {$argc != 4} {puts "wrong number of arguments to create_project.tcl"; puts $argc;exit 1}
set name [lindex $argv 0]
set version [lindex $argv 1]
set arm_core [lindex $argv 2]
set path [lindex $argv 3]
#Set SDK workspace path
setws $path

if { $arm_core == "ARM_CORE_0" } {
  set core_id 0
} else {
  set core_id 1
}

if {$name == "power_measurement" } {
  set bsp_proj .$name\_bsp
  set language c++
} else {
  set bsp_proj .FGPU_$version\_bsp
  set language c++
}

set hw_proj .MicroBlaze_hw
# set hw_proj .FGPU_$version\_hw

# Delete the project with the same name if already exist
catch {
  deleteprojects -name $name -workspace-only
}

# Create application projects
createapp -name $name -hwproject $hw_proj -bsp $bsp_proj -proc ps7_cortexa9_$core_id -os standalone -lang $language -app {Empty Application}
# Configure the projects for best optimization
configapp -app $name -set build-config {Release}
configapp -app $name -set compiler-optimization {Optimize most (-O3)}
# add math library for linking 
configapp -app $name -add libraries {m}
