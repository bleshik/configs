#!/bin/sh
curl "$2" > /tmp/play.mp3
ffmpeg -y -i "$1" -i /tmp/play.mp3 -c:v copy -shortest -map 0:v:0 -map 1:a:0 /tmp/replaced.mp4
mv /tmp/replaced.mp4 "$1"
