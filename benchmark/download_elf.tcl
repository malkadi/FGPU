connect

if { $benchmark == "power_measurement" } {
  # select the second ARM core as a target
  targets -set -filter {name =~ "ARM*#1"}
} elseif { $benchmark == "MicroBlaze" } {
  targets -set -filter {name =~ "MicroBlaze*"}
} else { 
  # select the first ARM core as a target
  targets -set -filter {name =~ "ARM*#0"}
}
# download elf file
set elfFile $benchmark/Release/$benchmark.elf

if {![file exists $elfFile]} {
  puts "Elf file not found!"
  exit 1
}

rst -processor

dow $elfFile
con
