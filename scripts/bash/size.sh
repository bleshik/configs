#!/bin/bash
INFO="`ffprobe -i "$1" 2>&1 | grep Stream | grep Video`"
w="`echo $INFO | sed -e 's/.* \([0-9]*\)x\([0-9]*\).*/\1/g'`"
h="`echo $INFO | sed -e 's/.* \([0-9]*\)x\([0-9]*\).*/\2/g'`"
if [ "$2" = "w" ] ; then
    echo $w
elif [ "$2" = "h" ]; then
    echo $h
elif [ "$2" = "smallest" ]; then
    echo $(($w>$h?$h:$w))
elif [ "$2" = "greatest" ]; then
    echo $(($w>$h?$h:$w))
elif [ "$2" = "resize" ] && [ ! -z "$3" ]; then
    if (( w > h )) ; then
        echo "-1:$3"
    else
        echo "$3:-1"
    fi
else
    echo ${w}x${h}
fi
