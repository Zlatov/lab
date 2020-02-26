#!/usr/bin/env bash

set -eu

cd "$(dirname "${BASH_SOURCE[0]}")"

# Такой вариант отключает скрин при остановке процесса:
# screen -dmS newma ./newma.sh

screen -dmS newma
sleep 2
screen -S newma -X stuff "/home/iadfeshchm/projects/my/lab/bash/_tasks/screen_startup/newma.sh^M"
