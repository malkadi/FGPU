connect

set powerElfFile power_measurement/Release/power_measurement.elf
if {![file exists $powerElfFile]} {
  puts "Elf file for power measurement not found!"
  exit 1
}
set elfFile $benchmark/Release/$benchmark.elf

if {![file exists $elfFile]} {
  puts "Elf file not found!"
  exit 1
}
# select the second ARM core as a target
targets -set -filter {name =~ "ARM*#1"}
rst -processor
# download power measurement elf file
dow $powerElfFile
con 
# con
if { $benchmark == "MicroBlaze"} {
  targets -set -filter {name =~ "MicroBlaze*"}
} else {
  # select the first ARM core as a target
  targets -set -filter {name =~ "ARM*#0"}
}
rst -processor
# download elf file
dow $elfFile
# con
con 



