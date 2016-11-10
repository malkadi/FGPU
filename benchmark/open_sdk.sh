#!/bin/sh
cd `dirname $0`
source ./set_paths.sh
cd `dirname $0`/$1
xsct -interactive -eval "setws `dirname $0`/$1"
