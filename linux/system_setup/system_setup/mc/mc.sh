#!/usr/bin/env bash
set -eu

cd ~
lab_path=projects/my/lab
. $lab_path/bash/_lib/echoc

[[ -z ${SYSTEM_SETUP_APT_UPDATE-} ]] && sudo apt-get -qq update

echoc "Копируем файл настройки ~/.config/mc/mc.ext." yellow
mkdir -p $HOME/.config/mc
cp ~/$lab_path/linux/system_setup/system_setup/mc/mc.ext ~/.config/mc
echoc "Скопирован файл настройки ~/.config/mc/mc.ext." green

if hash mc 2>/dev/null
then
  echoc "Уже установлен mc." blue
else
  echoc "Установка mc." yellow
  sudo apt-get install mc -y 1>/dev/null
  echoc "Установлен mc." green
fi
