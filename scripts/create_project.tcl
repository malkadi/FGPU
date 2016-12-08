if {$argc != 3} {puts "wrong number of arguments to create_project.tcl"; puts $argc;exit 1}
set name [lindex $argv 0]
set version [lindex $argv 1]
set path [lindex $argv 2]
#Set SDK workspace path
setws $path
# Delete the project with the same name if already exist
catch {
  deleteprojects -name $name -workspace-only
}
# Create application projects
createapp -name $name -hwproject .FGPU_$version\_hw -bsp .FGPU_$version\_bsp -proc ps7_cortexa9_0 -os standalone -lang c++ -app {Empty Application}
# Configure the projects for best optimization
configapp -app $name -set build-config {Release}
configapp -app $name -set compiler-optimization {Optimize most (-O3)}
# add math library for linking 
configapp -app $name -add libraries {m}
