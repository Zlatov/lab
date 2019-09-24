#!/usr/bin/env bash

set -eu

cd "$(dirname "${0}")"

mkdir -p ./split

# Очищаем ./split директорию для теста:
find ./split -type f -delete
find ./split -type d -not -path ./split | xargs -I {} rm -rf {}

# Создадим и наполним файл
touch ./split/temp_big_content
for (( i = 0; i < 45; i++ ))
do
  echo $i >> ./split/temp_big_content
done

mkdir -p ./split/separated
# Разбить по 10 строк с перемещением в другую папку и тут же префикс.
#           ┌─── что разбивать ────┐ ┌─ куда разбивать и префикс ──┐
#           │                      │ │                             │
split -l 10 ./split/temp_big_content ./split/separated/temp_content_
