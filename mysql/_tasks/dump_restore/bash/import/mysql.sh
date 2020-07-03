#!/usr/bin/env bash

set -eu

cd "$(dirname "${BASH_SOURCE[0]}")"

. ../_lib/mysql.sh

cd -

if [[ -z ${1-} ]]
then
  echo "Не указан файл дампа." 1>&2
  exit 1
fi

if [[ ! -f $1 ]]
then
	echo "Нет файла дампа." 1>&2
	exit 1
fi

echo "Начата процедура импорта mysql…" 

mysql --user="${MYSQL_USERNAME}" --host="${MYSQL_HOST}" --database="${DATABASE_NAME}" < "$1"

echo "Done." 
