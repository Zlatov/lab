#!/usr/bin/env bash
set -eu

cd ~
lab_path=projects/my/lab
. $lab_path/bash/_lib/echoc

cp ./$lab_path/linux/system_setup/system_setup/sublime-text/Packages/User/* .config/sublime-text-3/Packages/User
echoc "Настроен sublime Packages/User." green

path="$(pwd)/.config/sublime-text-3/Packages/Prefixw"
if [[ -d "$path" ]]
then
  echoc "Уже настроен sublime Prefixw." blue
else
  mkdir -p "$path"  1>/dev/null
  git clone https://github.com/Zlatov/prefixw.git "$path" 2>/dev/null
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