#!/usr/bin/env bash

set -eu

cd ~
lab_path=projects/my/lab
. $lab_path/bash/_lib/echoc
. $lab_path/bash/_lib/yn

if hash psql 2>/dev/null
then
  echoc "Уже установлен postgresql." blue
  yN "Удалить? [yes/NO]"
  if [[ $YN -eq 1 ]]
  then
    echoc "Не реализовано." red
    # sudo apt-get remove postgresql -y
  fi
else
  echoc "Установка postgresql." yellow
  # sudo apt-get install postgresql -y 1>/dev/null
  sudo apt-get install postgresql -y
  echoc "Установлен postgresql." green
fi
