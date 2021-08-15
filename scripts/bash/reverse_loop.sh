#!/usr/bin/env bash
source="$1"
if [ ! -z "$2" ] ; then
    output="$2"
else
    output="$1"
fi
EXT=`echo "${source##*.}"`

TMP="/tmp/`echo \"$1\" | md5`.$EXT"
ffmpeg -y -i "$source" -vb 22M -filter_complex "[0:v]reverse,fifo[r];[0:v][r] concat=n=2:v=1 [v]" -map "[v]" "$TMP"
mv "$TMP" "$output"
