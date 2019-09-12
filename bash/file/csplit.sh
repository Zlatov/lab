#!/usr/bin/env bash

set -eu

cd "$(dirname "${0}")"

mkdir -p ./csplit

# Очищаем ./csplit директорию для теста:
find ./csplit -type f -delete
find ./csplit -type d -not -path ./csplit | xargs -I {} rm -rf {}

# Создадим и наполним файл
touch ./csplit/temp_big_content
for (( i = 3; i < 6; i++ ))
do
  a=($(seq 0 1 $i))
  # echo ${a[@]}
  for v in ${a[@]}
  do
    echo $v >> ./csplit/temp_big_content
  done
  echo 'separator `' >> ./csplit/temp_big_content
done

# Разделим по регулярке /^separator `/
csplit --prefix=csplit/temp_ ./csplit/temp_big_content '/^separator `/' {*}

# Дополнительные параметры
# --suppress-matched     не обрабатывать строки, совпадающие с ШАБЛОНОМ
# -z, --elide-empty-files    удалять пустые выходные файлы
csplit --suppress-matched -z --prefix=csplit/temp_A ./csplit/temp_big_content /^separator/ {*}
