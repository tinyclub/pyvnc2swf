#!/bin/bash
#
# play.sh -- play the latest vnc session
#

TOP_DIR=$(cd $(dirname $0) && pwd)/../

PLAYER=${TOP_DIR}/pyvnc2swf/play.py
TOOLS=${TOP_DIR}/tools/
CONFIG=${TOOLS}/config

. ${CONFIG}

FPS=""
VNC_RECORD_FILE=""

[ -z "$RECORDINGS" ] && RECORDINGS=$VNC_RECORDINGS
[ -z "$FPS" ] && FPS=5
[ -n "$FPS" ] && FPS_OPT=" -r $FPS "

[ -z "$DEBUG" ] && DEBUG=0
[ $DEBUG -eq 1 ] && DEBUG_OPT=" -d "

[ -n "$1" ] && VNC_RECORD_FILE=$1
[ -z "$VNC_RECORD_FILE" ] && VNC_RECORD_FILE="$(ls -rt `find ${RECORDINGS} -type f -name '*vnc'` | tail -1)"
!(echo $VNC_RECORD_FILE | grep -q "vnc$") && \
	echo "Error: no vnc session with .novnc or .vnc suffix exist." && exit 1
VNC_RECORD_FILE=$(cd $(dirname $VNC_RECORD_FILE) && pwd)/$(basename $VNC_RECORD_FILE)

$PLAYER $FPS_OPT $DEBUG_OPT $VNC_RECORD_FILE
