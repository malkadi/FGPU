#!/bin/bash

# compiles an OpenCL file for FGPU and generates the log files 
# Two options are needed:
#   1. The file to be compiled
#   2. If hard floating-point support is required, use the option -hard-float

# E.g. ./compile_and_log.sh bitonic_hard_float.cl -hard-float.cl

outputDir="compiler_outputs/"
logDir=$outputDir
cd `dirname $0`

HARD_FLOAT=0
for option in "$@"
do
  if [ $option = "-hard-float" ]; then # hard-float feature
    HARD_FLOAT=1
  elif [ -f $option ]; then # OpenCL file to compile
    fileName=`basename $option`
  fi
done


fileNameLen=${#fileName}
outFileName_ll=$outputDir${fileName:0:$fileNameLen-2}"ll"
outFileName_s=$outputDir${fileName:0:$fileNameLen-2}"s"
outFileName_bin=$outputDir${fileName:0:$fileNameLen-2}"bin"
logAsmFileName=$logDir${fileName:0:$fileNameLen-2}"s.log"
logObjFileName=$logDir${fileName:0:$fileNameLen-2}"bin.log"
logObjDumpFileName=$logDir${fileName:0:$fileNameLen-2}"objdump.log"
cFileName=$outputDir${fileName:0:$fileNameLen-2}"c"
hFileName=$outputDir${fileName:0:$fileNameLen-2}"h"
cramFileName=$outputDir"cram.mif"
objdumpFileName=$logDir${fileName:0:$fileNameLen-2}"objdump"
BIN_DIR="../llvm-3.7.1.build/bin/"
LLC_ARGS="-march=fgpu -asm-verbose -print-after-all -debug -relocation-model=static -debug-pass=Details"

if [ $HARD_FLOAT -eq 1 ]; then
  LLC_ARGS=$LLC_ARGS" -mattr=+fgpu-hard-float"
else
  LLC_ARGS=$LLC_ARGS" -mattr=-fgpu-hard-float"
fi

BLOCKS_TO_DRAW="entry"
$BIN_DIR"clang" -O3 -S -emit-llvm  -target "mips-unknown-uknown" -o $outFileName_ll -x cl $fileName
if [ $? != 0 ]; then
  echo "clang failed"
  exit $?
fi
$BIN_DIR"llc" $LLC_ARGS -filetype=asm -filter-view-dags=$BLOCKS_TO_DRAW -view-sched-dags -o $outFileName_s $outFileName_ll &> $logAsmFileName

# $BIN_DIR"llc" $LLC_ARGS -filetype=asm -view-isel-dags -filter-view-dags=$BLOCKS_TO_DRAW -o $outFileName_s $outFileName_ll &> $logAsmFileName
# $BIN_DIR"llc" $LLC_ARGS -filetype=asm -view-isel-dags -o $outFileName_s $outFileName_ll &> $logAsmFileName

# $BIN_DIR"llc" $LLC_ARGS -filetype=asm -view-dag-combine2-dags -filter-view-dags=$BLOCKS_TO_DRAW -o $outFileName_s $outFileName_ll &> $logAsmFileName
# $BIN_DIR"llc" $LLC_ARGS -filetype=asm -view-dag-combine2-dags -o $outFileName_s $outFileName_ll &> $logAsmFileName

# $BIN_DIR"llc" $LLC_ARGS -filetype=asm -view-legalize-dags -filter-view-dags=$BLOCKS_TO_DRAW  -o $outFileName_s $outFileName_ll &> $logAsmFileName
# $BIN_DIR"llc" $LLC_ARGS -filetype=asm -view-legalize-dags -o $outFileName_s $outFileName_ll &> $logAsmFileName

# $BIN_DIR"llc" $LLC_ARGS -filetype=asm -view-dag-combine1-dags -filter-view-dags=$BLOCKS_TO_DRAW -o $outFileName_s $outFileName_ll &> $logAsmFileName
# $BIN_DIR"llc" $LLC_ARGS -filetype=asm -view-dag-combine1-dags -o $outFileName_s $outFileName_ll &> $logAsmFileName

# $BIN_DIR"llc" $LLC_ARGS -filetype=asm -o $outFileName_s $outFileName_ll &> $logAsmFileName

a=$?
if [ $a != 0 ]; then
  echo "llc assembly generation failed (exit code = "$a")"
  exit $a
fi

$BIN_DIR"llc" $LLC_ARGS -filetype=obj -o $outFileName_bin $outFileName_ll &> $logObjFileName

if [ $? != 0 ]; then
  echo "llc obj generation failed"
  exit $?
fi


# $BIN_DIR"llvm-objdump" -d -debug $outFileName_bin &>$logObjDumpFileName

$BIN_DIR"llvm-objdump" -d $outFileName_bin | tee $objdumpFileName | cat 
if [ $? != 0 ]; then
  echo "objdump failed"
  exit $?
fi

# objdump -s $outFileName_bin 
# objdump --headers $outFileName_bin 
offset="0x"$(objdump --headers $outFileName_bin | gawk -n '/text/ {print $6}')
size="0x"$(objdump --headers $outFileName_bin | gawk -n '/text/ {print $3}')
offset_words=$((offset/4))
size_words=$((size/4))
# echo $offset_words
# echo $size_words

text_section=$(objdump -s $outFileName_bin | 
gawk '{if (NR > 4) {print $2; print $3; print $4; print $5}}' |
head -$size_words)
text_section=($text_section)

kernel_addresses=$(
$BIN_DIR"llvm-objdump" -d $outFileName_bin |
awk 'FNR > 4' |
sed -n '/^\S/ {n; p}' | 
awk '{print "0x"substr($1, 0, length($1)-1)}'
)

kernel_names=$(
$BIN_DIR"llvm-objdump" -d $outFileName_bin |
sed -n '/^\S/ p' |
gawk '
{ 
  if (FNR > 2)
  {
    print substr($0, 0, length($0)-1);
  }
}')

# for cram-mif
function_names=($kernel_names)
function_addresses=($kernel_addresses)
num_functions=0
tmp=0
for word in "${function_names[@]}"; do
  if [ ${word:0:3} != "LBB" ]; then
    function_names[$num_functions]=${function_names[$tmp]}
    function_addresses[$num_functions]=$((function_addresses[$tmp]/4))
    # printf "${function_names[$num_functions]}\n"
    # indices[$num_functions]=$tmp
    ((num_functions++))
  fi
  ((tmp++))
done

function_names=(${function_names[@]:0:num_functions})
function_addresses=(${function_addresses[@]:0:num_functions})
function_addresses+=($size_words)

# printf $num_functions" functions found:\n"
# printf "%s\t\n" "${function_names[@]}"
# echo ${function_addresses[@]}
kernel_names=($kernel_names)
kernel_addresses=($kernel_addresses)
# declare -i indices
tmp=0
num_kernels=0
for word in "${kernel_names[@]}"; do
  if [[ ${word:0:3} != "LBB" && ${word:0:1} != "_" ]]; then
    kernel_names[$num_kernels]=${kernel_names[$tmp]}
    kernel_addresses[$num_kernels]=$((kernel_addresses[$tmp]/4))
    # indices[$num_kernels]=$tmp
    ((num_kernels++))
  fi
  ((tmp++))
done



kernel_names=(${kernel_names[@]:0:num_kernels})
kernel_addresses=(${kernel_addresses[@]:0:num_kernels})
kernel_addresses+=($size_words)
# printf $num_kernels" kernels found:"
# printf "%s\t" "${kernel_names[@]}"
# echo ${kernel_addresses[@]}
tmp=0
> $hFileName
> $cFileName
> $cramFileName
codeVecName=${fileName:0:$fileNameLen-3}
printf "#define " >> $hFileName
printf "%-36s" "${codeVecName^^}_LEN" >> $hFileName
echo "$((kernel_addresses[$num_kernels]))" >> $hFileName
kernel_index=0
while [ $kernel_index -lt $num_kernels ]; do
  printf "#define " >> $hFileName
  printf "%-36s" "${kernel_names[$kernel_index]^^}_POS" >> $hFileName
  echo "$((kernel_addresses[kernel_index]))" >> $hFileName
  # echo -e "#define "${kernel_names[$kernel_index]^^}"_LEN\t\t"$((kernel_addresses[kernel_index+1]-kernel_addresses[kernel_index])) >> $cFileName
  ((kernel_index++))
done

echo "unsigned int "$codeVecName"[] = {" >> $cFileName
word_indx=0
kernel_index=0
function_index=0
while [ $word_indx -lt ${#text_section[@]} ]; do
  if [ $word_indx = ${kernel_addresses[$kernel_index]} ]; then
    ((kernel_index++))
  fi
  if [ $((word_indx+1)) = ${kernel_addresses[$num_kernels]} ]; then
    printf "\t0x"${text_section[$word_indx]:6:2}${text_section[$word_indx]:4:2}${text_section[$word_indx]:2:2}${text_section[$word_indx]:0:2}"\n};\n" >> $cFileName
  else
    printf "\t0x"${text_section[$word_indx]:6:2}${text_section[$word_indx]:4:2}${text_section[$word_indx]:2:2}${text_section[$word_indx]:0:2}",\n" >> $cFileName
  fi
  if [ $word_indx = ${function_addresses[$function_index]} ]; then
    ((function_index++))
  fi
  if [ $word_indx = ${function_addresses[$((function_index-1))]} ]; then
    echo -e ${text_section[$word_indx]:6:2}${text_section[$word_indx]:4:2}${text_section[$word_indx]:2:2}${text_section[$word_indx]:0:2}" -- begin "${function_names[$((function_index-1))]} >> $cramFileName
  elif [ $((word_indx+1)) = ${function_addresses[$function_index]} ]; then
    echo -e ${text_section[$word_indx]:6:2}${text_section[$word_indx]:4:2}${text_section[$word_indx]:2:2}${text_section[$word_indx]:0:2}" -- end "${function_names[$((function_index-1))]} >> $cramFileName
  else
    echo -e ${text_section[$word_indx]:6:2}${text_section[$word_indx]:4:2}${text_section[$word_indx]:2:2}${text_section[$word_indx]:0:2} >> $cramFileName
  fi
  ((word_indx++))
done

echo "unsigned *code = "$codeVecName";" >> $cFileName

# echo ${kernel_names[@]}
# echo ${kernel_addresses[@]}

# /home/muhammed/ESITGPU/llvm-3.7.1_build/bin/llc -march=fgpu -filetype=asm -o $outFileName_s $outFileName_ll &> $logFileName
# /home/muhammed/ESITGPU/llvm-3.7.1_build/bin/llc -march=fgpu -filetype=obj -o $outFileName_bin $outFileName_ll &> /dev/null
# llc_args=""
# for (( c=0; c <= $[$# - 1]; c++ ))
# do
# 	# echo $c
# 	# echo ${args[$c]}
# 	case ${args[$c]} in
# 		"-o") llc_args+=" -filetype=obj"
# 	esac
# done
# echo $llc_args
# echo ${#llc_args[@]}
# llc -march=mips $llc_args -mcpu=mips32 -o $outFileName_s $outFileName_ll
# llvm-as < /dev/null | llc -march=mips -mcpu=help


# llc -march=mips -filetype=obj -mcpu=mips32 -o $outFileName_bin $outFileName_ll
# llc -march=mips -filetype=asm -mcpu=mips32 -o $outFileName_s $outFileName_ll

# arm-linux-gnu-objdump -d .text test_peripherlas.elf
# ~/ESITGPU/llvm-3.7.1_build/bin/opt -view-cfg  compiler_outputs/vec_mul.ll 
