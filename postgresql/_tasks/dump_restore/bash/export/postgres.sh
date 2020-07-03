#!/usr/bin/env bash

# Можно запускать кроном этот скрипт для сохранения пяти последних дампов в
# bash/export/postgres:
# 15 0 * * * $HOME/app/bash/export/postgres.sh >> $HOME/app/log/cron_export_postgres.log 2>&1

set -eu

cd "$(dirname "${BASH_SOURCE[0]}")"

if [[ -f ./config.sh ]]
then
	set -a
	. ./config.sh
	set +a
else
	echo "Отсутствует конфигурационный файл, выполните: cp config-example.sh config.sh" 1>&2
	exit 1
fi

if [[ -d ./postgres ]]
then
	echo "Директория для дампа существует."
else
	mkdir -p ./postgres
	echo "Создана директория для дампа."
fi

if [[ -z ${DATABASE_NAME-} ]]
then
	echo "Переменная DATABASE_NAME не установлена." 1>&2
	exit 1
fi
if [[ -z ${USERNAME-} ]]
then
	echo "Переменная USERNAME не установлена." 1>&2
	exit 1
fi
if [[ -z ${PGPASSWORD-} ]]
then
	echo "Переменная PGPASSWORD не установлена." 1>&2
	exit 1
fi

DATABASE_DATE=$(date +%Y-%m-%d-%H-%M-%S)
DATABASE_PATH="postgres/${DATABASE_NAME}-${DATABASE_DATE}.pg"

{
  pg_dump --file="${DATABASE_PATH}" --dbname="${DATABASE_NAME}" --username="${USERNAME}" --no-owner --format=c
} && {
	if tty -s
	then
		echo "Удаление дампов до пяти последних производится не будет (произведён интерактивный запуск скрипта)."
	else
		echo "Производим удаление до пяти послидних дампов."
		(ls postgres -t | head -n 5; ls postgres) | sort | uniq -u | xargs -I {} rm postgres/{}
	fi
	echo "${DATABASE_PATH} done."
} || {
	echo "Ошибка экспортирования." 1>&2
}
