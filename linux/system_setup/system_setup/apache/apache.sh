#!/usr/bin/env bash

set -eu

cd ~
lab_path=projects/my/lab
. $lab_path/bash/_lib/echoc

if hash apache2 2>/dev/null
then
  echoc "Уже установлен apache2." blue
else
  echoc "Установка apache2." yellow
  sudo apt-get -y install apache2 1>/dev/null
  echoc "Установлен apache2." green
fi

# Подключение модуля mod_rewrite
if [[ -f /etc/apache2/mods-enabled/rewrite.load ]]
then
  echoc "Уже настроен apache2 подключён модуль mod_rewrite." blue
else
  sudo ln -s /etc/apache2/mods-available/rewrite.load /etc/apache2/mods-enabled/rewrite.load
  echoc "Настроен apache2 подключён модуль mod_rewrite." green
fi

# Подключение модуля proxy
if [[ -z ${RECONFIGURE-} && -f /etc/apache2/mods-enabled/proxy.load ]]
then
  echoc "Уже подключён модуль proxy, proxy_http." blue
else
  echoc "Подключение модуля proxy, proxy_http." yellow
  sudo a2enmod proxy 1>/dev/null
  sudo a2enmod proxy_http 1>/dev/null
  echoc "Подключён модуль proxy, proxy_http." green
fi

# AddDefaultCharset
if [[ -f "/etc/apache2/conf-available/charset.conf" ]] && egrep -q "^AddDefaultCharset UTF-8" /etc/apache2/conf-available/charset.conf
then
  echoc "Уже настроен apache default encoding." blue
else
  if [ -f "/etc/apache2/conf-available/charset.conf" ]
  then
    echo "AddDefaultCharset UTF-8" | sudo tee -a /etc/apache2/conf-available/charset.conf
    sudo service apache2 restart 1>/dev/null
    echoc "Настроен apache default encoding." green
  else
    echoc "Файл настройки не найден." yellow
    echoc "Добавте директиву AddDefaultCharset UTF-8 в файл настройки." yellow
    echo -n "Нажмите Enter для продолжения."; read A
  fi
fi

# if [[ -d /etc/apache2/sites-available && -d /etc/apache2/sites-enabled ]]
# then
#   if [[ -z ${RECONFIGURE-} && -f /etc/apache2/sites-available/my.conf && -f /etc/apache2/sites-enabled/my.conf ]]
#   then
#     echoc "Уже настроен список виртуальных хостов my.conf." blue
#   else
#     echoc "Настройка списока виртуальных хостов my.conf." yellow
#     mkdir -p $HOME/projects/my/lorem_yii/backend/web
#     mkdir -p $HOME/projects/my/lorem_yii/frontend/web
#     sudo cp $lab_path/linux/system_setup/system_setup/apache/my.conf /etc/apache2/sites-available 1>/dev/null
#     sudo a2ensite my.conf 1>/dev/null
#     echoc "Настроен список виртуальных хостов my.conf." green
#   fi
#   if [[ -z ${RECONFIGURE-} && -f /etc/apache2/sites-available/zenon.conf && -f /etc/apache2/sites-enabled/zenon.conf ]]
#   then
#     echoc "Уже настроен список виртуальных хостов zenon.conf." blue
#   else
#     echoc "Настройка списока виртуальных хостов zenon.conf." yellow
#     mkdir -p ~/projects/zenon/sign-forum
#     sudo cp -t /etc/apache2/sites-available $lab_path/linux/system_setup/system_setup/apache/zenon.conf 1>/dev/null
#     sudo a2ensite zenon.conf 1>/dev/null
#     echoc "Настроен список виртуальных хостов zenon.conf." green
#   fi
# else
#   echoc "Неизвестная для скрипта файловая конфигурация." red
#   echoc "Воспользуйтесь фалом ${lab_path}/linux/system_setup/system_setup/apache/my.conf для настройки списка виртуальных хостов my.conf." red
#   echo -n "Нажмине Enter для продолжения."; read A
# fi

{
  egrep -iq "^127.0.0.1 lab.local" /etc/hosts
} && {
  echoc "Хост lab.local существует." blue
} || {
  echoc -n "Добавление хоста lab.local…" yellow
  echo "127.0.0.1 lab.local www.lab.local" | sudo tee -a /etc/hosts >/dev/null
  echo -ne "\r\033[0K"
  echoc "Добавлен хост lab.local." green
}

# {
#   egrep -iq "^127.0.0.1 admin.zenonline.local" /etc/hosts
# } && {
#   echoc "Хост admin.zenonline.local существует." blue
# } || {
#   echoc -n "Добавление хоста admin.zenonline.local…" yellow
#   echo "127.0.0.1 admin.zenonline.local www.admin.zenonline.local" | sudo tee -a /etc/hosts >/dev/null
#   echo -ne "\r\033[0K"
#   echoc "Добавлен хост admin.zenonline.local." green
# }

echoc -n "Перезапуск сервиса apache2…" yellow
sudo service apache2 restart 1>/dev/null
echo -ne "\r\033[0K"
echoc "Перезапущен сервис apache2." green
