#!/bin/bash
#
# Please run as root.
# Usage: bash findport.sh 3000 100
#

if [[ -z "$1" || -z "$2" ]]; then
    echo "Usage: $0 <base_port> <increment>"
    exit 1
fi

BASE=$1
INCREMENT=$2

port=$BASE
isfree=$(netstat -talnp tcp | grep "[^0-9]\+$port\s")

while [[ -n "$isfree" ]]; do
    port=$[port+INCREMENT]
    isfree=$(netstat -talnp tcp | grep "[^0-9]\+$port\s")
done

echo "$port"
exit 0
