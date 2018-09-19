#!/usr/bin/env bash
set -eu

cd $(dirname "$0")

# Очищаем текущую директорию для теста:
find . -type f -not -name scp.sh -delete
find . -type d -not -path . | xargs -I {} rm -rf {}
# exit 0

# ssh zlatov mkdir temp
# ssh zlatov echo "hi"
# ssh zlatov pwd
# ssh zlatov "cd temp && touch temp"
# ssh zlatov "[[ ! -d temp ]] && mkdir temp || echo 'dir exist'; rm -rf temp"

ssh zlatov '
  [[ -d temp ]] && rm -rf temp || echo "temp not exists"
  mkdir temp
  touch temp/temp_f
  mkdir -p temp/temp_d
  touch temp/temp_d/temp_f2
'
# Копирование файла с переименованием и с "подставой"
mkdir temp_f_copy2
scp zlatov:~/temp/temp_f temp_f_copy  # создаст с новым именеи
scp zlatov:~/temp/temp_f temp_f_copy2 # положит в папку

# Выход:
# mkdir temp_f_copy3
scp zlatov:~/temp/temp_f ./ && mv -T temp_f temp_f_copy3

# Рекурсивное копирование папки
mkdir temp_dest
scp -r zlatov:~/temp ./temp_dest

# Рекурсивное копирование содержимого папки
mkdir temp_dest2
scp -r zlatov:~/temp/* ./temp_dest2
