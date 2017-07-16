#!/bin/bash

# This script downloads and compiles LLVM v3.7.1 with FGPU support

DOWNLOAD_DIR="/tmp"       # tempral directory to download the source files
N_THREADS=2               # number of threads for compilation
COMPILE_STRATEGY="Debug"  # set at "Release" for shorter compilation times. Set to "Debug" for debugging your LLVM code.

SCRIPTS_DIR=`dirname $0`

LOG_FILE=$SCRIPTS_DIR"/download_and_compile_llvm.log"
LLVM_SRC_NAME="llvm-3.7.1"
CLANG_SRC_NAME="cfe-3.7.1"

cd `dirname $0`/../ # go to FGPU main directory

HOME_DIR=`pwd`
LLVM_SRC_DIR=`pwd`"/"$LLVM_SRC_NAME.src
LLVM_BUILD_DIR=`pwd`/$LLVM_SRC_NAME.build

>$LOG_FILE #clean log file

if [ -d $DOWNLOAD_DIR ]; then
  cd $DOWNLOAD_DIR
else
  echo "The given download dirctory ("$DOWNLOAD_DIR") does not exist or it is not a directory!"
  exit
fi

# download llvm-3.7.1 if not already done
if [ ! -e $LLVM_SRC_NAME".src.tar.xz" ]; then
  echo "Downloading LLVM!"
  wget "http://releases.llvm.org/3.7.1/"$LLVM_SRC_NAME".src.tar.xz" &>> $LOG_FILE
  a=$?
  if [ $a != 0 ]; then
    echo "Downloaing llvm failed (exit code = "$a")!"
    echo "See "$LOG_FILE
    exit $a
  fi
else
  echo $LLVM_SRC_NAME".src.tar.xz (llvm source code) already found in "$DOWNLOAD_DIR", no need for download!"
fi

# download clang if not already done
if [ ! -e $CLANG_SRC_NAME".src.tar.xz" ]; then
  wget "http://releases.llvm.org/3.7.1/"$CLANG_SRC_NAME".src.tar.xz" &>> $LOG_FILE
  a=$?
  if [ $a != 0 ]; then
    echo "Downloaing clang failed (exit code = "$a")!"
    echo "See "$LOG_FILE
    exit $a
  fi
else
  echo $CLANG_SRC_NAME"src..tar.xz (clang source code) already found in "$DOWNLOAD_DIR", no need for download!"
fi

echo "Delete old LLVM source files!"
rm -rf $LLVM_SRC_DIR
a=$?
if [ $a != 0 ]; then
  echo "Delete old LLVM source files failed (exit code = "$a")!"
  echo "See "$LOG_FILE
  exit $a
fi

echo "Extract LLVM source files!"
tar xvf $LLVM_SRC_NAME.src.tar.xz -C $HOME_DIR &> $LOG_FILE
a=$?
if [ $a != 0 ]; then
  echo "Extracting LLVM failed (exit code = "$a")!"
  echo "See "$LOG_FILE
  exit $a
fi

echo "Extracting clang source files!"
tar xvf $CLANG_SRC_NAME.src.tar.xz -C $HOME_DIR"/"$LLVM_SRC_NAME".src/tools" &> $LOG_FILE
a=$?
if [ $a != 0 ]; then
  echo "Extracting clang failed (exit code = "$a")!"
  echo "See "$LOG_FILE
  exit $a
fi

if [ ! -d $LLVM_BUILD_DIR ]; then
  mkdir $LLVM_BUILD_DIR
fi

cd $LLVM_BUILD_DIR
echo "Generating makefiles for LLVM with clang for MIPS without FGPU!"
cmake -DCMAKE_CXX_COMPILER=g++ -DCMAKE_C_COMPILER=gcc -DCMAKE_BUILD_TYPE=Release -DLLVM_TARGETS_TO_BUILD="Mips" -G "Unix Makefiles" $LLVM_SRC_DIR

a=$?
if [ $a != 0 ]; then
  echo "cmake failed (exit code = "$a")!"
  exit $a
fi

echo "Compiling LLVM with clang!"
make -j$N_THREADS

a=$?
if [ $a != 0 ]; then
  echo "Compilation failed (exit code = "$a")!"
  exit $a
fi

echo "clang source files will be deleted (to avoid recompiling clang when recompiling llvm)!"
rm -rf $LLVM_SRC_DIR/tools/$CLANG_SRC_NAME.src

a=$?
if [ $a != 0 ]; then
  echo "Deleting clang source files (exit code = "$a")!"
  exit $a
fi

echo "Add FGPU backend files to the LLVM source directory!"
SRC=$HOME_DIR/$LLVM_SRC_NAME".src.fgpu/"
DST=$HOME_DIR/$LLVM_SRC_NAME.src/
ln -sf $SRC"CMakeLists.txt" $DST
ln -sf $SRC"cmake/config-ix.cmake" $DST"cmake/"
ln -sf $SRC"include/llvm/ADT/Triple.h" $DST"include/llvm/ADT/"
ln -sf $SRC"include/llvm/Object/ELFObjectFile.h" $DST"include/llvm/Object/"
ln -sf $SRC"include/llvm/Support/ELF.h" $DST"include/llvm/Support/"
ln -sf $SRC"lib/Support/Triple.cpp" $DST"lib/Support/"
ln -sf $SRC"lib/Target/LLVMBuild.txt" $DST"lib/Target/"
ln -sf $SRC"lib/Target/Fgpu" $DST"lib/Target/"


echo "Generating makefiles for LLVM and FGPU!"
cmake -DCMAKE_CXX_COMPILER=g++ -DCMAKE_C_COMPILER=gcc -DCMAKE_BUILD_TYPE=$COMPILE_STRATEGY -DLLVM_TARGETS_TO_BUILD="Fgpu" -G "Unix Makefiles" $LLVM_SRC_DIR

a=$?
if [ $a != 0 ]; then
  echo "cmake failed (exit code = "$a")!"
  exit $a
fi

echo "Compiling LLVM for FGPU!"
make -j$N_THREADS


a=$?
if [ $a != 0 ]; then
  echo "Compilation failed (exit code = "$a")!"
  exit $a
fi
