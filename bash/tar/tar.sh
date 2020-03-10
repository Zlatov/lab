#!/usr/bin/env bash

set -eu

cd "$(dirname "${0}")"

# Очищаем директорию для теста:
filename=$(basename -- "${BASH_SOURCE[0]}") # Имя текущего исполняемого файла.
test_dirname="${filename%.*}" # Имя тестовой директории - это имя текущего файла без расширения.
mkdir -p ./$test_dirname
find ./$test_dirname -type f -delete
find ./$test_dirname -type d -not -path ./$test_dirname | xargs -I {} rm -rf {}


# 
# tar
# 
# -f — на диске, а не на магнитной ленте, эта опция должна быть __последней__ при указании имени архива;
# -c — создать архив;
# -x — извлекать файлы из архива;
# -z — через gzip (.tar.gz, .tgz, .tar.gzip);
# -j — через bzip2 (.tar.bz2, .tar.bzip2, .tbz2, .tb2, .tbz);
# -v — вывод информации во время обработки;
# -t — просмотреть содержимое архива;
# -r — добавить в архив;
# -O, --to-stdout — extract files to standard output;
# 
# Примеры
# ```
# tar -cf tarName.tar filename # — создать несжатый архив.
# tar -rf tarName.tar filename # — добавить в несжатый архив.
# tar -czf tarName.tar.gz filename # — создать сжатый gzip-ом архив.
# tar -xf tarName.tar.gz # — извлечь.
# tar -xzOf tarName.tar.gz | mysql -uUSERNAME -pPASSWORD databaseName
# ```
# 
