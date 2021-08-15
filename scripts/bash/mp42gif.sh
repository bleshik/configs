#!/bin/sh

ffmpeg -i "$1" -vf "scale=320:-1:flags=lanczos" -c:v pam -f image2pipe - | convert -delay 10 - -loop 0 -layers optimize "`echo \"$1\" | sed -e 's/.mp4/.gif/'`"
