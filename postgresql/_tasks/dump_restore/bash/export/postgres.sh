#!/usr/bin/env bash

# Можно запускать кроном этот скрипт для сохранения пяти последних дампов в
# bash/export/postgres:
# 15 0 * * * $HOME/app/bash/export/postgres.sh >> $HOME/app/log/cron_export_postgres.log 2>&1

set -eu

cd "$(dirname "${BASH_SOURCE[0]}")"

. ../_lib/postgres.sh

if [[ -d ./postgres/exports ]]
then
	echo "Директория для дампа существует."
else
	mkdir -p ./postgres/exports
	echo "Создана директория для дампа."
fi

DATABASE_DATE=$(date +%Y-%m-%d-%H-%M-%S)
DATABASE_PATH="postgres/exports/${DATABASE_NAME}-${DATABASE_DATE}.pg"

{
	echo "Начат процесс экспорта ${DATABASE_NAME}…"
  pg_dump --file="${DATABASE_PATH}" --dbname="${DATABASE_NAME}" --username="${USERNAME}" --no-owner --format=c
} && {
	echo "Экспорт ${DATABASE_NAME} успешно завершен."
	if tty -s
	then
		echo "Удаление дампов до пяти последних производится не будет (произведён интерактивный запуск скрипта)."
	else
		echo "Производим удаление до пяти послидних дампов."
		(ls postgres -t | head -n 5; ls postgres) | sort | uniq -u | xargs -I {} rm postgres/{}
	fi
} || {
	echo "Ошибка экспортирования." 1>&2
}
