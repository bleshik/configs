#!/bin/sh
ffmpeg -y -i "$1" -vf 'scale=80:80' -lossless 1 "`echo \"$1\" | sed -e 's/.MP4/.thumbnail.webp/gi'`"
