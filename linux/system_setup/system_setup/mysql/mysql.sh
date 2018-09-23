#!/usr/bin/env bash
set -eu

cd ~
lab_path=projects/my/lab
. $lab_path/bash/_lib/echoc

[[ -z ${SYSTEM_SETUP_APT_UPDATE-} ]] && sudo apt-get -qq update

if hash mysql 2>/dev/null
then
  echoc "Уже установлен mysql." blue
else
  echoc "Установка mysql." yellow
  sudo apt-get install mysql-server -y 1>/dev/null
  echoc "Установлен mysql." green
fi

sudo mysql_secure_installation
