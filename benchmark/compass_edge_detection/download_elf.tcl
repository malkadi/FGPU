# select the first ARM core as a target
targets -set -filter {name =~ "ARM*#0"}
# download elf file
dow Release/compass_edge_detection.elf

