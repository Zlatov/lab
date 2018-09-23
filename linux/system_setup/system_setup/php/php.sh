#!/usr/bin/env bash
set -eu

cd ~
lab_path=projects/my/lab
. $lab_path/bash/_lib/echoc

# 
# Обновление списка пакетов в соответствии с доверенными репозиториями
# 

[[ -z ${SYSTEM_SETUP_APT_UPDATE-} ]] && sudo apt-get -qq update

# 
# Установка
# 

if hash php 2>/dev/null
then
  echoc "Уже установлен php." blue
else
  echoc "Установка php." yellow
  sudo apt-get install php -y 1>/dev/null
  echoc "Установлен php." green
fi

# 
# Установка библиотек
# 

echoc "Установка php библиотек." yellow
sudo apt-get install -y php-{bcmath,bz2,intl,gd,mbstring,mysql,zip} && sudo apt-get install libapache2-mod-php -y
echoc "Установлены php библиотеки." green
