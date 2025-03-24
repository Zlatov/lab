#!/usr/bin/env bash

# Запуск этого скрипта:
# ~/projects/my/lab/linux/system_setup/system_setup/bashrc/bashrc.sh
# Затем:
# source ~/.bashrc
# или `. ~/.bashrc`

set -eu

cd ~
lab_path=projects/my/lab
. $lab_path/bash/_lib/echoc

echoc "Копируем файл .bashrc-iadfeshchm в домашнюю директорию." yellow
cp ~/$lab_path/linux/system_setup/system_setup/bashrc/.bashrc-iadfeshchm ~/
echoc "Скопирован файл .bashrc-iadfeshchm в домашнюю директорию." green

if [[ -f ~/.bashrc ]] && egrep -q "^\[\[ -s ~/.bashrc-iadfeshchm \]\] && source ~/.bashrc-iadfeshchm" ~/.bashrc
then
  echoc "Уже настроено подключение .bashrc-iadfeshchm в .bashrc." blue
else
  echoc "Настраиваем подключение .bashrc-iadfeshchm в .bashrc." yellow
  echo "[[ -s ~/.bashrc-iadfeshchm ]] && source ~/.bashrc-iadfeshchm" | tee -a ~/.bashrc
  echoc "Настроено подключение .bashrc-iadfeshchm в .bashrc." green
fi
