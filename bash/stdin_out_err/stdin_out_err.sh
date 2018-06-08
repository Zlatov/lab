#!/bin/bash
. ../_lib/echoc

touch temp
> temp

# Десерипторы (номер) ввода/вывода: STDIN:0 STDOUT:1 STDERR:0

echoc 'Вывод всего в стандартый вывод' 'green'
ls stdin_out_err.sh nofile

echoc 'Подавление всего вывода' green
ls stdin_out_err.sh nofile &>/dev/null

echoc 'Подавление вывода норм' green
ls stdin_out_err.sh nofile >/dev/null
ls stdin_out_err.sh nofile 1>/dev/null

echoc 'Подавление вывода ошибок' green
ls stdin_out_err.sh nofile 2>/dev/null

echoc 'Ошибки в стандартный вывод, а нормы подавляем' green
ls stdin_out_err.sh nofile 2>&1 >/dev/null
echoc 'не наоборот (не работает)' yellow
ls stdin_out_err.sh nofile >/dev/null 2>&1

echoc 'Нормы в файл' green
ls stdin_out_err.sh nofile 1>./temp
echo 'asd' 1>>./temp
