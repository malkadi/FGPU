# select the first ARM core as a target
targets -set -filter {name =~ "MicroBlaze*"}
# download elf file
dow Release/MicroBlaze.elf

