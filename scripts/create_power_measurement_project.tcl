if {$argc != 2} {puts "wrong number of arguments to create_PM_project.tcl"; puts $argc;exit 1}
set name [lindex $argv 0]
set path [lindex $argv 1]
#Set SDK workspace path
setws $path

set HW_PROJ .FGPU_V2_hw
set bsp_name .$name\_bsp

# Create the HW project
if {![file exists $path/$HW_PROJ]} {
  error "Hardware project not found"
  exit
}
catch {
  deleteprojects -name $name -workspace-only
}
catch {
  deleteprojects -name $bsp_name
}
# Create  BSP projects
createbsp -name $bsp_name -hwproject $HW_PROJ -proc ps7_cortexa9_1 -os standalone
# Create application projects
createapp -name $name -hwproject $HW_PROJ -bsp $bsp_name -proc ps7_cortexa9_1 -os standalone -lang c++ -app {Empty Application}
# Configure the projects for best optimization
configapp -app $name -set build-config {Release}
configapp -app $name -set compiler-optimization {Optimize most (-O3)}
# add math library for linking 
configapp -app $name -add libraries {m}
# Build bsp
projects -build -type bsp -name $bsp_name

