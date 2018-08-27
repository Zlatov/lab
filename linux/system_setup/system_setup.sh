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
echoc "Обновлён список доступных пакетов." green

if hash curl 2>/dev/null
then
  echoc "Уже установлен curl." blue
else
  sudo apt-get install curl
  echoc "Установлен curl." green
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

if [[ ! $(git config --global core.excludesfile) = "" && -f ~/.gitexcludes ]]
then
  echoc "Уже настроен git gitexcludes." blue
else
  cp $lab_path/linux/system_setup/system_setup/git/.gitexcludes ~/.gitexcludes
  git config --global core.excludesfile ~/.gitexcludes
  echoc "Настроен git gitexcludes." green
fi

./$lab_path/linux/system_setup/system_setup/apache/apache.sh

cp ./$lab_path/linux/system_setup/system_setup/sublime-text-3/Packages/User/* .config/sublime-text-3/Packages/User
echoc "Настроен sublime Packages/User." green

path="$(pwd)/.config/sublime-text-3/Packages/Prefixw"
if [[ -d "$path" ]]
then
  echoc "Уже настроен sublime Prefixw." blue
else
  mkdir -p "$path"  1>/dev/null
  git clone https://github.com/Zlatov/prefixw.git "$path"  2>/dev/null
  echoc "Настроен sublime Prefixw." green
fi

path="$(pwd)/.config/sublime-text-3/Packages/CollapseFolders"
if [[ -d "$path" ]]
then
  echoc "Уже настроен sublime CollapseFolders." blue
else
  mkdir -p "$path" 1>/dev/null
  git clone https://github.com/Zlatov/CollapseFolders.git "$path" 2>/dev/null
  echoc "Настроен sublime CollapseFolders." green
fi
