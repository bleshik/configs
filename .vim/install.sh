#!/bin/bash - 
set -o nounset
PLUGIN_NAME="`echo \"$1\" | cut -d \"/\" -f 2`"
BASE="`dirname $0`"
[ ! -d "$BASE/bundle/$PLUGIN_NAME" ] && git submodule add "https://github.com/$1" "$BASE/bundle/$PLUGIN_NAME"
