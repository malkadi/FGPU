#!/bin/sh
cd `dirname $0`
source ./set_paths.sh
if [ $# -ne 1 ]; then
  echo "Please give a project name!"
  exit 1
fi
cd ..
xsct -eval "setws `pwd`; projects -build -type app -name $1"

