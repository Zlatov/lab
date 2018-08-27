#!/usr/bin/env bash

# 
# cd ~ && mkdir -p projects/my/lab
# git clone git@github.com:Zlatov/lab.git projects/my/lab
# cd ~ && sudo projects/my/lab/linux/system_setup/system_setup.sh
# 

set -eu

cd ~

sudo apt-get update

lab_path=projects/my/lab
. $lab_path/bash/_lib/echoc

if hash curl 2>/dev/null
then
  echoc 'Уже установлен curl.' blue
else
  echoc 'Установка curl.' green
  sudo apt-get install curl
  echoc 'Установлен curl.' green
fi

if hash yarn 2>/dev/null
then
  echoc 'Уже установлен yarn.' blue
else
  echoc 'Установка yarn.' green
  curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
  echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
  sudo apt-get update && sudo apt-get install yarn
  echoc 'Установлен yarn.' green
fi

echoc 'Настройка git gitexcludes.' green
git config --global core.excludesfile ~/.gitexcludes
cp $lab_path/linux/system_setup/system_setup/git/.gitexcludes ~/.gitexcludes
echoc 'Настроен git gitexcludes.' green

echoc 'Настройка apache2 подключаем модуль mod_rewrite.' green
sudo ln -s /etc/apache2/mods-available/rewrite.load /etc/apache2/mods-enabled/rewrite.load
echoc 'Настроен apache2 подключён модуль mod_rewrite.' green

echoc 'Настройка apache default encoding.' green
echo "Добавте директиву AddDefaultCharset UTF-8 в файл настройки."
if [ -f '/etc/apache2/conf-available/charset.conf' ]
then
  echoc "Файл настройки найден, открываем." green
  subl /etc/apache2/conf-available/charset.conf
else
  echoc 'Файл настройки не найден.' red
fi
echo -n 'Нажмите Enter для продолжения.'; read A

echoc 'Настройка sublime Prefixw.' green
prefixw_path="~/.config/sublime-text-3/Packages/Prefixw"
if [[ -d "$prefixw_path" ]]
then
  echoc 'Уже настроен sublime Prefixw.' blue
else
  mkdir -p "$prefixw_path"
  git clone https://github.com/Zlatov/prefixw.git "$prefixw_path"
fi
echoc 'Настроен sublime Prefixw.' green

echoc 'Настройка sublime CollapseFolders.' green
collapse_folders_path="~/.config/sublime-text-3/Packages/CollapseFolders"
if [[ -d "$prefixw_path" ]]
then
  echoc 'Уже настроен sublime Prefixw.' blue
else
  mkdir -p "$collapse_folders_path"
  git clone git@github.com:Zlatov/CollapseFolders.git "$collapse_folders_path"
fi
echoc 'Настроен sublime CollapseFolders.' green
