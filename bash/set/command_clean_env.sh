#!/usr/bin/env bash

A=AAA

export D='DDD' # будет видна в ./command.sh

set -a

. ./var.sh # назначенные тут переменные будут видны в ./command.sh (будут экспортированы)

set +a

. ./var2.sh # `С` не будет видна в ./command.sh

echo "---"
echo "In clean env:"
echo '$A: ' $A
echo '$B: ' $B
echo '$C: ' $C
echo '$D: ' $D
echo '$DEVELOPER_HOST: ' $DEVELOPER_HOST
echo '$HOME: ' $HOME
echo ~

./command.sh
