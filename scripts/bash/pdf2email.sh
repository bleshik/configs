#!/bin/sh
pdftotext -enc UTF-8 "$1" /tmp/tmp.txt

TEXT="`cat /tmp/tmp.txt`"

EMAIL="`echo \"$TEXT\" | grep @ | head -1 | grep -i -o '[A-Z0-9._%+-]\+@[A-Z0-9.-]\+\.[A-Z]\{2,4\}'`"

if [ -z "`echo \"$TEXT\" | grep 'hidden\|скрыто'`" ] ; then
    if [ ! -z "`echo \"$TEXT\" | head -1 | grep -i 'online\|Был\|Сейчас на сайте'`" ] ; then
        NAME="`echo \"$TEXT\" | tail -n +3 | head -1`"
    else
        NAME="`echo \"$TEXT\" | head -1`"
    fi
    echo "$NAME <$EMAIL>"
else
    echo $EMAIL
fi

