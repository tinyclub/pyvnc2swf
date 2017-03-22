#!/bin/bash
#
# play.sh -- play the latest vnc session
#

TOP_DIR=$(cd $(dirname $0) && pwd)/../

PLAYER=${TOP_DIR}/pyvnc2swf/play.py
RECORDINGS=${TOP_DIR}/recordings/

[ -z "$FPS" ] && FPS=5
[ -n "$FPS" ] && FPS_OPT=" -r $FPS "

[ -z "$DEBUG" ] && DEBUG=0
[ $DEBUG -eq 1 ] && DEBUG_OPT=" -d "

[ -n "$1" ] && VNC_RECORD_FILE=$1
[ -z "$VNC_RECORD_FILE" ] && VNC_RECORD_FILE=`ls -rt ${RECORDINGS}/*vnc | tail -1`
[ -z "$VNC_RECORD_FILE" ] && echo "Log: No vnc record file specified" && exit 1
VNC_RECORD_FILE=$(cd $(dirname $VNC_RECORD_FILE) && pwd)/$(basename $VNC_RECORD_FILE)

$PLAYER $FPS_OPT $DEBUG_OPT $VNC_RECORD_FILE
