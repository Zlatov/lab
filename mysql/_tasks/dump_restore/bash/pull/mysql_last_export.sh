#!/usr/bin/env bash

set -eu

cd "$(dirname "${BASH_SOURCE[0]}")"

. ../_lib/ssh.sh

if [[ ! -d ../export/mysql/exports ]]
then
	mkdir -p ../export/mysql/exports
	echo "Создана директория для дампов."
fi

LAST_EXPORT=$(ssh $REMOTE_SERVER "ls ${REMOTE_PATH}/bash/export/mysql/exports -t | head -n 1")
if [[ -n "${LAST_EXPORT-}" ]]
then
	echo "Обнаружен последний дамп ${LAST_EXPORT}, начинаем копирование."
	scp "${REMOTE_SERVER}":"${REMOTE_PATH}/bash/export/mysql/exports/${LAST_EXPORT}" ../export/mysql/exports
else
	echo "Не обнаружен дамп."
	exit 0
fi

echo "Done."
