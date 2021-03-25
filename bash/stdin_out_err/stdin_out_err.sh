#!/bin/bash
. ../_lib/echoc

touch temp
> temp

temp_path='./temp'

# Десерипторы (номер) ввода/вывода: STDIN:0 STDOUT:1 STDERR:2

# echoc 'Подавление по условию' green
# (
# 	exec 3>&1 &>/dev/null
# 	echo 'Вывод подпадающий под условное подавление' >&3
# 	echo 'Нормальный вывод'
# )
# (
# 	exec 3>&1
# 	echo 'Вывод подпадающий под условное подавление' >&3
# 	echo 'Нормальный вывод'
# )
# exit 0

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

echoc 'Ошибки в лог-файл, а нормы подавляем' green
ls stdin_out_err.sh nofile 2>>$temp_path >/dev/null
echo '' &>/dev/null

echoc 'Нормы в файл' green
ls stdin_out_err.sh nofile 1>./temp
echo 'asd' 1>>$temp_path

echoc 'Всё в обычный вывод и в лог файл' green
echo 'Норма в обычный вывод и в лог файл' 2>&1 | tee -a $temp_path
echo 'Ошибка в обычный вывод и в лог файл' 2>&1 | tee -a $temp_path
# или
echo 'Норма в обычный вывод и в лог файл' |& tee -a $temp_path
echo 'Ошибка в обычный вывод и в лог файл' |& tee -a $temp_path
