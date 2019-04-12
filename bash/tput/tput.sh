#!/usr/bin/env bash

set -eu

cd "$(dirname "${0}")"

. ../_lib/echoc

echo "hi"
echo "hi"
sleep 1

# Очистить весь экран (или область устройства).
tput clear >/dev/tty
sleep 1

echo "hi"
sleep 1
exit


tput rmcup >/dev/tty
tput smcup >/dev/tty

# Сохранить текущую позицию (save cursor).
tput sc >/dev/tty
tput rc >/dev/tty
