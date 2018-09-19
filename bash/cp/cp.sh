#!/usr/bin/env bash
set -eu

cd $(dirname "$0")

# Очищаем текущую директорию для теста:
find . -type f -not -name cp.sh -delete
find . -type d -not -path . | xargs -I {} rm -rf {}
# exit 0


# Небольшая жопа при копировании (выполняются разные действия в зависимости от окружения):
touch "temp"
mkdir "temp_2"
cp temp temp_1       # ./temp скопирует в ./temp_1
cp temp temp_2       # ./temp скопирует в ./temp_2/temp

# Избавляемся от двоякости способами:

# Указываем директорию в которую копируем `-t path`
mkdir "temp_3"
cp -t ./temp_3 temp  # ./temp скопирует в ./temp_3/temp

# Указываем что назначение является именем файла `-T`
cp -T temp temp_4    # ./temp скопирует в ./temp_4

# Копирование содержимого папки в папку
mkdir "temp_dest"
mkdir "temp_dest2"
mkdir -p "./temp_2/temp_f"
cp -r -t temp_dest temp_2/* # скопирует содержимое папки temp_2
cp -r -t temp_dest2 temp_2  # скопирует папку с содержимым
