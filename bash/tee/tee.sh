#!/usr/bin/env bash

set -eu

cd $(dirname "$0")

. ../_lib/echoc

# Очистка вспомогательных файлов
touch temp && > temp
touch temp_append && > temp_append

echoc "„Правильная“ запись в файл." green
echo asd | tee temp >/dev/null
echo asd | tee temp >/dev/null

echoc "„Правильная“ дозапись в файл." green
echo zxc | tee -a temp_append >/dev/null
echo zxc | tee -a temp_append >/dev/null

# echo "10.192.1.36 lab.zlatov www.lab.zlatov" | sudo tee -a /etc/hosts >/dev/null
