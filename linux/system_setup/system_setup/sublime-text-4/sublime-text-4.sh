#!/usr/bin/env bash

# Использование: ctrl+b

set -eu

cd ~
lab_path=projects/my/lab
. $lab_path/bash/_lib/echoc

echo "Удаление сниппетов."
rm -rf .config/sublime-text/Packages/User/snippets
echo "Копирование сниппетов, билдов и настроек пакетов."
cp -r ./$lab_path/linux/system_setup/system_setup/sublime-text-4/Packages/User/* .config/sublime-text/Packages/User
echo "Копирование настройки jsbeautifyrc."
[[ -f ./$lab_path/linux/system_setup/system_setup/sublime-text-4/Packages/User/.jsbeautifyrc ]] && \
cp ./$lab_path/linux/system_setup/system_setup/sublime-text-4/Packages/User/.jsbeautifyrc .config/sublime-text/Packages/User/.jsbeautifyrc || echo &>/dev/null
echoc "Настроен sublime Packages/User." green

# path="$(pwd)/.config/sublime-text/Packages/Prefixw"
# if [[ -d "$path" ]]
# then
#   echoc "Уже настроен sublime Prefixw." blue
# else
#   mkdir -p "$path"  1>/dev/null
#   git clone https://github.com/Zlatov/prefixw.git "$path" 2>/dev/null
#   echoc "Настроен sublime Prefixw." green
# fi

echoc "Добавление пакета CollapseFolders отключено." red
# path="$(pwd)/.config/sublime-text/Packages/CollapseFolders"
# if [[ -d "$path" ]]
# then
#   echoc "Уже настроен sublime CollapseFolders." blue
# else
#   mkdir -p "$path" 1>/dev/null
#   git clone https://github.com/Zlatov/CollapseFolders.git "$path" 2>/dev/null
#   echoc "Настроен sublime CollapseFolders." green
# fi
