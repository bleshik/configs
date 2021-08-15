#!/bin/bash
if [ -n "`echo \"$1\" | grep '.pdf'`" ] ; then
    pdftotext -enc UTF-8 "$1" /tmp/tmp.txt
    TEXT="`cat /tmp/tmp.txt`"
else
    TEXT="`pandoc -i \"$1\" | sed -e 's/\<[^\>]*\>//g' | grep '\S'`"
fi

EMAIL="`echo \"$TEXT\" | grep -EiEio '\b[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\b' | head -1`"

if [ -z "$EMAIL" ] ; then
    exit 1
fi

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
