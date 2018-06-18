#!/bin/bash
set -eu

cd $(dirname $0)
. ../_lib/echoc

echoc '_Команда_ вывода содержимого текущего файла расписания' green
echoc 'crontab -l' blue

echoc '_Команда_ удаление текущего файла расписания:' green
echoc 'crontab -r' blue

echoc '_Команда_ создания/редактирования файла crontab текущего пользователя:' green
echoc 'crontab -e' blue

# EDITOR=nano crontab -e

echoc 'Текущий файл расписания:' green
crontab -l
