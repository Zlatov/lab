#!/usr/bin/env bash

set -eu

. ../_lib/echoc


# 
# -q  Немногословный режим. В стандартный выходной поток не выдается ничего,
#     кроме сопоставившихся строк. Если одна из входных строк соответствует
#     образцу, возвращается статус выхода 0.
# 

ls -la ./ | grep 'grep'
ls -la ./ | grep -q 'grep'
if ls -la ./ | grep -q 'grep'
then
  echo 'grep'
fi
if ls -la ./ | grep -q 'grepp'
then
  echo 'grepp'
else
  echo 'no grepp'
fi


# -i - регистронезависимо;
# -r - рекурсивно обходя папки;
# --include=*.php - только файлы с шаблоном (--include=*.{php,html}).
grep 'Hello world' ./example.cpp

# Регистронезависимо:
grep -i sum ./example.cpp

# Регулярка (но лучше использовать egrep):
grep -i N[ua]m1 ./example.cpp
# . - замена любого печатного символа
# * - отсутствие или повторение символа
# ^ - начало строки
# $ - конец строки

# Вывести номер строки (ключ -n)
grep -i -n hello ./example.cpp
# egrep с использованием символьных классов POSIX (с привычными регулярными выражениями)
egrep -i 'Hel+' ./example.cpp

# Ограничить длинну выводимой (найденной) строки
ps aux | egrep '(USER)|(nginx)' | cut -c -255

# Поиск по файлам в директории
# Во всех файлах текущей директории
grep "BASH_VERSION" ./*
# В скрытых файлах
grep "BASH_VERSION" ./.*

# Найдена ли строка в файле
echo 'asd' > temp
if [[ -f temp ]] && egrep -q "^asd" temp
then
  echoc yes green
else
  echoc no red
fi

# Количество строк с совпадениями
status=$(echo 'asd' | grep -c 'f')
echo '$status: ' $status
status=$(echo 'asd' | grep -c 's')
echo '$status: ' $status

a=' asd'
# if echo $a | grep -e '\s]asd'
# then
#   echoc nashel green
# else
#   echoc nenashel red
# fi

echo ' asd' > temp
if echo "${a}" | grep -e '\s\asd'
then
  echoc nashel green
else
  echoc nenashel red
fi
