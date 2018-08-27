#!/usr/bin/env bash
set -eu

cd ~
lab_path=projects/my/lab
. $lab_path/bash/_lib/echoc

# Подключение модуля mod_rewrite
if [[ -f /etc/apache2/mods-enabled/rewrite.load ]]
then
  echoc "Уже настроен apache2 подключён модуль mod_rewrite." blue
else
  sudo ln -s /etc/apache2/mods-available/rewrite.load /etc/apache2/mods-enabled/rewrite.load
  echoc "Настроен apache2 подключён модуль mod_rewrite." green
fi

# AddDefaultCharset
if [[ -f "/etc/apache2/conf-available/charset.conf" ]] && egrep -q "^AddDefaultCharset UTF-8" /etc/apache2/conf-available/charset.conf
then
  echoc "Уже настроен apache default encoding." blue
else
  if [ -f "/etc/apache2/conf-available/charset.conf" ]
  then
    sudo echo "AddDefaultCharset UTF-8" >> /etc/apache2/conf-available/charset.conf
    sudo service apache2 restart 1>/dev/null
    echoc "Настроен apache default encoding." green
  else
    echoc "Файл настройки не найден." yellow
    echoc "Добавте директиву AddDefaultCharset UTF-8 в файл настройки." yellow
    echo -n "Нажмите Enter для продолжения."; read A
  fi
fi

if [[ -d /etc/apache2/sites-available && -d /etc/apache2/sites-enabled ]]
then
  if [[ -f /etc/apache2/sites-available/my.conf && -f /etc/apache2/sites-enabled/my.conf ]]
  then
    echoc "Уже настроен список виртуальных хостов my.conf." blue
  else
    sudo cp $lab_path/linux/system_setup/system_setup/apache/my.conf /etc/apache2/sites-available 1>/dev/null
    sudo a2ensite my.conf 1>/dev/null
    echoc "Настроен список виртуальных хостов my.conf." green
  fi
else
  echoc "Неизвестная для скрипта файловая конфигурация." red
  echoc "Воспользуйтесь фалом ${lab_path}/linux/system_setup/system_setup/apache/my.conf для настройки списка виртуальных хостов my.conf." red
  echo -n "Нажмине Enter для продолжения."; read A
fi
