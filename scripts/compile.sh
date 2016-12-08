#!/bin/sh
cd `dirname $0`
source ./set_paths.sh
if [ $# -ne 1 ]; then
  echo "Please give the project path!"
  exit 1
fi
benchmark=`basename $1`
path=`dirname $1`
xsct -quiet -eval "setws $path; projects -build -type app -name $benchmark"

