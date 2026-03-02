#!/usr/bin/env bash

# Использование:
# ctrl+b
# или
# ~/projects/my/lab/linux/system_setup/system_setup/sublime-text/sublime-text-preferences.sh

set -eu

echo "Копирование настроек."
cp \
  ~/projects/my/lab/linux/system_setup/system_setup/sublime-text/Packages/User/Preferences.sublime-settings \
  ~/.config/sublime-text/Packages/User

echo -e "\e[32mDone.\e[0m"
