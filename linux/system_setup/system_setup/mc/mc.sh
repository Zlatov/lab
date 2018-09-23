#!/usr/bin/env bash
set -eu

cd ~
lab_path=projects/my/lab
. $lab_path/bash/_lib/echoc

[[ -z ${SYSTEM_SETUP_APT_UPDATE-} ]] && sudo apt-get -qq update

if hash mc 2>/dev/null
then
  echoc "Уже установлен mc." blue
else
  echoc "Установка mc." yellow
  sudo apt-get install mc -y 1>/dev/null
  echoc "Установлен mc." green
fi
