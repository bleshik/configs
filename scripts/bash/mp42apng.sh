#!/bin/sh
TMP="/tmp/`echo \"$1\" | md5`"
mkdir "$TMP"
ffmpeg -y -i "$1" -vf 'scale=80:80' $TMP/%4d.png
for i in $TMP/*.png ; do echo "$i" ; pngquant --quality 60 "$i" ; done
apngasm "$TMP/*-fs8.png" -d 40 -o "`echo \"$1\" | sed -e 's/.MP4/.thumbnail.apng/g'`"
rm -rf $TMP
