
# файлы из субдиректорий в какую-то директорию
find . -mindepth 2 -type f -print -exec mv {} . \;
