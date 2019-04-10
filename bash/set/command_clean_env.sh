#!/usr/bin/env bash

A=AAA

set -a

. ./var.sh

set +a

echo "---"
echo "In clean env:"
echo '$A: ' $A
echo '$B: ' $B
echo '$DEVELOPER_HOST: ' $DEVELOPER_HOST
echo '$HOME: ' $HOME
echo ~

./command.sh
