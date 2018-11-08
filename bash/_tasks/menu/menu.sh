#!/usr/bin/env bash

set -eu

cd "$(dirname "${0}")"

. ../../_lib/echoc

# Очищаем текущую директорию для теста:
find . -type f -not -name menu.sh -not -name menu -delete
find . -type d -not -path . | xargs -I {} rm -rf {}

. ../../_lib/menu

touch temp
echo -e "первый\nвторой\nтретий" | tee temp >/dev/null

options=$(echo -e "первый\nвторой\nтретий")
# или
options="первый
второй
третий"
# или
options=$(cat ./temp)

# echo "$options"
# exit 0

# tput smcup
choise=$(menu <<< "$options")
# tput rmcup
echo "choise: ${choise}"
choise=$(menu -h "выберите:" <<< "$options")
echo "choise: ${choise}"
choise=$(echo -e "первый\nвторой\nтретий" | menu -h "выберите:")
echo "choise: ${choise}"
