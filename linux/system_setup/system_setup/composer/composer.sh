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

if hash composer 2>/dev/null
then
  echoc "Уже установлен composer." blue
else
  echoc "Установка composer." yellow
  cd ~
  curl -sS https://getcomposer.org/installer | php
  sudo mv composer.phar /usr/local/bin/composer
  # composer global require "fxp/composer-asset-plugin:~1.1.1"
  echoc "Установлен composer." green
fi
