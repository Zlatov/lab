#!/usr/bin/env bash

# Использование:
# ctrl+b
# или
# ~/projects/my/lab/linux/system_setup/system_setup/sublime-text/sublime-text-snippets.sh

set -eu

echo "Удаление сниппетов."
rm -rf ~/.config/sublime-text/Packages/User/snippets

echo "Копирование сниппетов."
cp -r \
  ~/projects/my/lab/linux/system_setup/system_setup/sublime-text/Packages/User/snippets/ \
  ~/.config/sublime-text/Packages/User

echo "Удаление автодополнений."
rm ~/.config/sublime-text/Packages/User/completions.sublime-completions

echo "Копирование автодополнений."
cp \
  ~/projects/my/lab/linux/system_setup/system_setup/sublime-text/Packages/User/completions.sublime-completions \
  ~/.config/sublime-text/Packages/User

echo -e "\e[32mDone.\e[0m"
