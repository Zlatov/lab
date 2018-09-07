#!/bin/bash
set -eu

. ../echoc

echoc "color green" green
echoc "new red line" red
echo "new line with $(echoc -n red red) and $(echoc -n green green) words"
