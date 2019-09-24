#!/usr/bin/env bash
set -eu

cd `dirname "$0"`
. "../_lib/echoc"

[[ ! -d "temp_d" ]] && mkdir "temp_d" || `echo`

echoc "все" green
find ./
echoc "файлы" green
find ./ -type f
echoc "png файлы" green
find ./ -type f -name "*.png"
echoc "папки" green
find . -type d
echoc "папки кроме" green
find . -type d -mindepth 1
find . -type d ! -path .
find . -type d -not -path .

exit 0
# файлы из субдиректорий в какую-то директорию
find . -mindepth 2 -type f -print -exec mv {} . \;

# Найти пути с папкой bash внутри в текущей папке (уровень 0)
find ./*/bash -maxdepth 0 -type d
