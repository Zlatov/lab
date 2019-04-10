#!/usr/bin/env bash

echo "---"
echo "In start env:"
echo '$A: ' $A
echo '$B: ' $B
echo '$DEVELOPER_HOST: ' $DEVELOPER_HOST
echo '$HOME: ' $HOME
echo ~

env -i ./command_clean_env.sh
