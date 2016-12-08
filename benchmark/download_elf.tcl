connect
# select the first ARM core as a target
targets -set -filter {name =~ "ARM*#0"}
# download elf file
set elfFile $benchmark/Release/$benchmark.elf
if {![file exists $elfFile]} {
  puts "Elf file not found!"
  exit 1
}

dow $elfFile
