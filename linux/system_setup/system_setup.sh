#!/usr/bin/env bash
set -eu

# 
# cd ~ && mkdir -p projects/my/lab
# git clone git@github.com:Zlatov/lab.git projects/my/lab
# cd ~ && projects/my/lab/linux/system_setup/system_setup.sh
# 

cd ~
lab_path=projects/my/lab
. $lab_path/bash/_lib/echoc

sudo apt-get -qq update
SYSTEM_SETUP_APT_UPDATE=true
echoc "Обновлён список доступных пакетов." green

if hash curl 2>/dev/null
then
  echoc "Уже установлен curl." blue
else
  sudo apt-get -y install curl 1>/dev/null
  echoc "Установлен curl." green
fi

if hash xdotool 2>/dev/null
then
  echoc "Уже установлен xdotool." blue
else
  sudo apt-get -y install xdotool 1>/dev/null
  echoc "Установлен xdotool." green
fi

if hash yarn 2>/dev/null
then
  echoc "Уже установлен yarn." blue
else
  curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
  echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
  sudo apt-get update && sudo apt-get install yarn
  echoc "Установлен yarn." green
fi

./$lab_path/linux/system_setup/system_setup/mc/mc.sh
./$lab_path/linux/system_setup/system_setup/python/python.sh
./$lab_path/linux/system_setup/system_setup/git/git.sh
./$lab_path/linux/system_setup/system_setup/bashrc/bashrc.sh
./$lab_path/linux/system_setup/system_setup/apache/apache.sh
./$lab_path/linux/system_setup/system_setup/mysql/mysql.sh
./$lab_path/linux/system_setup/system_setup/php/php.sh
./$lab_path/linux/system_setup/system_setup/composer/composer.sh
./$lab_path/linux/system_setup/system_setup/sublime-text/sublime-text.sh
