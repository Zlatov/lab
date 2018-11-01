#!/usr/bin/env bash

set -eu

cd $(dirname "$0")

. ../_lib/echoc

# Очищаем текущую директорию для теста:
find . -type f -not -name "grep.sh" -not -name "grep+.sh" -delete
find . -type d -not -path . | xargs -I {} rm -rf {}
# exit 0

echoc "Поиск в файле." green
touch temp
echo "asd" | tee temp >/dev/null
if grep "asd" temp >/dev/null
then
  echo "asd найдено"
else
  echo "asd не найдено"
fi
if grep "zxc" temp >/dev/null
then
  echo "zxc найдено"
else
  echo "zxc не найдено"
fi
# exit 0

echoc "Поиск в echo." green
touch temp
echo "asd" | tee temp >/dev/null
if echo "asd" | grep "asd" >/dev/null
then
  echo "asd найдено"
else
  echo "asd не найдено"
fi
if echo "asd" | grep "zxc" >/dev/null
then
  echo "zxc найдено"
else
  echo "zxc не найдено"
fi
# exit 0
