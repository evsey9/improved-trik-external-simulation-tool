#!/bin/bash
# Usage: unix_scr.sh <path to program dir> <path to js file> <path to fields dir> <path to TRIK studio>
TRIK_DIR=$4
PROGRAM_PATH=$1
FIELDS_PATH=$1/$3
DEFAULT_PROJECT=$PROGRAM_PATH/default.qrs
if [ -f "$DEFAULT_PROJECT" ]; then
    PROJECT_TYPE=xml
else 
    PROJECT_TYPE=qrs
fi

mydir=$(pwd)
cd $FIELDS_PATH
for f in *.$PROJECT_TYPE
do
	if [[ "$PROJECT_TYPE" == "xml" ]];
	then
		$TRIK_DIR/patcher -f $f $DEFAULT_PROJECT
		$TRIK_DIR/patcher -s $mydir/$2 $DEFAULT_PROJECT
		$TRIK_DIR/2D-model --mode script $DEFAULT_PROJECT --console
	fi
	if [[ "$PROJECT_TYPE" == "qrs" ]];
	then
		$TRIK_DIR/bin/patcher -s $mydir/$2 $f
		$TRIK_DIR/bin/2D-model --mode script $f --console
	fi
done
rm lastCode.py