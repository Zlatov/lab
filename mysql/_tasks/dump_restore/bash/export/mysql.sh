#!/usr/bin/env bash

# Можно запускать кроном этот скрипт для сохранения пяти последних дампов в
# bash/export/mysql:
# 15 0 * * * $HOME/app/bash/export/mysql.sh >> $HOME/app/log/cron_export_mysql.log 2>&1

set -eu

cd "$(dirname "${BASH_SOURCE[0]}")"

. ../_lib/mysql.sh

if [[ -d ./mysql/exports ]]
then
	echo "Директория для дампов существует."
else
	mkdir -p ./mysql/exports
	echo "Создана директория для дампов."
fi

DATABASE_DATE=$(date +%Y-%m-%d-%H-%M-%S)
DATABASE_PATH="mysql/exports/${DATABASE_NAME}-${DATABASE_DATE}.sql"

{
	echo "Начинаем процедуру mysqldump."
	mysqldump --user="${MYSQL_USERNAME}" --host="${MYSQL_HOST}" --routines --triggers "${DATABASE_NAME}" > "${DATABASE_PATH}"
} && {
	echo "${DATABASE_PATH} done."
	if tty -s
	then
		echo "Удаление дампов до пяти последних производится не будет (произведён интерактивный запуск скрипта)."
	else
		echo "Производим удаление до пяти послидних дампов."
		(ls mysql/exports -t | head -n 5; ls mysql/exports) | sort | uniq -u | xargs -I {} rm mysql/exports/{}
	fi
} || {
	echo "Ошибка экспортирования." 1>&2
}
