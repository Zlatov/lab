#!/usr/bin/env bash
set -eu

cd ~
lab_path=projects/my/lab
. $lab_path/bash/_lib/echoc

if hash python3.7 2>/dev/null
then
  echoc "Уже установлен python3.7." blue
  sudo update-alternatives --install /usr/bin/python python /usr/bin/python3.7 1
else
  if [[ $(apt-cache search python3.7 | egrep -c "^python3\.7\s+") -eq 1 ]]
  then
    sudo apt-get install -y python3.7 1>/dev/null
    sudo update-alternatives --install /usr/bin/python python /usr/bin/python3.7 1
    echoc "Установлен python3.7." green
  else
    echoc "Не найден пакет python3.7." yellow
  fi
fi

if hash python3.5 2>/dev/null
then
  echoc "Уже установлен python3.5." blue
  sudo update-alternatives --install /usr/bin/python python /usr/bin/python3.5 1
else
  if [[ $(apt-cache search python3.5 | egrep -c "^python3\.5\s+") -eq 1 ]]
  then
    sudo apt-get install -y python3.5 1>/dev/null
    echoc "Установлен python3.5." green
  else
    echoc "Не найден пакет python3.5." yellow
  fi
fi

sudo update-alternatives --config python
echoc "Настроена версия python." green

if [[ ! $(dpkg-query -W -f='${Status}' python-pip 2>/dev/null | grep -c "ok installed") -eq 0 ]]
then
  echoc "Уже установлен python-pip." blue
else
  sudo apt-get install -y python-pip 1>/dev/null
  echoc "Установлен python-pip." green
fi

if [[ ! $(dpkg-query -W -f='${Status}' python3-pip 2>/dev/null | grep -c "ok installed") -eq 0 ]]
then
  echoc "Уже установлен python3-pip." blue
else
  sudo apt-get install -y python3-pip 1>/dev/null
  echoc "Установлен python3-pip." green
fi

sudo pip install termcolor 1>/dev/null
echoc "Установлен pip пакет termcolor." green
