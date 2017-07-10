set name [lindex $argv 0]
# check parameters
if { $name == "power_measurement" } {
  if {$argc != 2} {puts "wrong number of arguments to create_sdk_bsp.tcl"; puts $argc;exit 1}
  set path [lindex $argv 1]
} else {
  if {$argc != 3} {puts "wrong number of arguments to create_sdk_bsp.tcl"; puts $argc;exit 1}
  set hdf  [lindex $argv 1]
  set path [lindex $argv 2]
}

#Set SDK workspace path
setws $path

if { $name == "power_measurement" } {
  # set hw_proj .MicroBlaze_hw
  set hw_proj .FGPU_V2_hw
  set bsp_proj .$name\_bsp

  #delete bsp project if already exists
  catch {
    deleteprojects -name $bsp_proj
  }

  createbsp -name $bsp_proj -hwproject $hw_proj -proc ps7_cortexa9_1 -os standalone
  
} else {
  set hw_proj .$name\_hw
  set bsp_proj .$name\_bsp
  
  #delete hw and bsp projects if already exists
  catch {
    deleteprojects -name $bsp_proj
    deleteprojects -name $hw_proj
  }

  # Create the HW project
  createhw -name $hw_proj -hwspec $hdf

  # Create  BSP projects
  if { $name == "MicroBlaze" } {
    createbsp -name $bsp_proj -hwproject $hw_proj -proc microblaze_0 -os standalone
  } else {
    createbsp -name $bsp_proj -hwproject $hw_proj -proc ps7_cortexa9_0 -os standalone
  }
}


# Build bsp
projects -build -type bsp -name $bsp_proj
