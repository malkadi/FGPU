# select the first ARM core as a target
targets -set -filter {name =~ "ARM*#0"}
# download elf file
dow Release/copy.elf

