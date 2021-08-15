#!/usr/bin/env bash
source="$1"
if [ ! -z "$2" ] ; then
    output="$2"
else
    output="$1"
fi
EXT=`echo "${source##*.}"`
TMP="/tmp/`echo \"$1\" | md5`.$EXT"
video_duration=`ffprobe -v error -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 "$source"`
fade_duration="0.5"
offset=$(bc -l <<< $video_duration-$fade_duration-1)
printf -v roffset "%.1f\n" ${offset/./,}
ffmpeg -y -i "$source" -vb 15M -filter_complex "[0]trim=end=1,setpts=PTS-STARTPTS[begin];[0]trim=start=1,setpts=PTS-STARTPTS[end];[end][begin]xfade=fade:duration=${fade_duration}:offset=${roffset/,/.},format=yuv420p" "$TMP"
mv "$TMP" "$output"
