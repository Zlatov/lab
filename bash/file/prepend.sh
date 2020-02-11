#!/bin/bash

set -eu

cd $(dirname "$0")

. ../_lib/echoc

# Очищаем директорию для теста:
filename=$(basename -- "${BASH_SOURCE[0]}") # Имя текущего исполняемого файла.
test_dirname="${filename%.*}" # Имя тестовой директории - это имя текущего файла без расширения.
mkdir -p ./$test_dirname
# find . -type f -not -name array.sh -delete
# find . -type d -not -path . | xargs -I {} rm -rf {}
find ./$test_dirname -type f -delete
find ./$test_dirname -type d -not -path ./$test_dirname | xargs -I {} rm -rf {}
# exit 0

touch prepend/temp_file

echo 'asd' >> prepend/temp_file
echo 'asd' >> prepend/temp_file
echo 'asd' >> prepend/temp_file

echo $'qwe\n'"$(cat prepend/temp_file)" > prepend/temp_file
echo $'qwe\n'"$(cat prepend/temp_file)" > prepend/temp_file
