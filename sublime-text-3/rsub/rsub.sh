#!/usr/bin/env bash
exit 0

# Устнаовка
# 1. Установить плагин в сублайм:
# Preference -> Packag Control -> `install` -> `rsub`
# 2. Добавить к хосту проброс порта: 
subl ~/.ssh/config
RemoteForward 52698 localhost:52698
# 3. На удалённой машин установить rmate:
wget -O ~/rmate https://raw.githubusercontent.com/aurora/rmate/master/rmate
chmod u+x ~/rmate
cd ~ && touch temp && ~/rmate temp
