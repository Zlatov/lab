#!/usr/bin/env bash

set -eu

cd "$(dirname "${0}")"

. ../_lib/echoc

exit 0

tput clear >/dev/tty

tput rmcup >/dev/tty
tput smcup >/dev/tty

tput sc >/dev/tty
tput rc >/dev/tty
