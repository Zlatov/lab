#!/usr/bin/env bash

set -eu

cd "$(dirname "${BASH_SOURCE[0]}")"

. ../_lib/postgres.sh

cd -

if [[ -z "${1-}" ]]
then
  echo "Не указан файл дампа." 1>&2
  exit 1
fi

if [[ ! -f "${1}" ]]
then
	echo "Нет файла дампа." 1>&2
	exit 1
fi

{
	echo "Начат импорт ${DATABASE_NAME} из ${1}"
  dropdb -U "${USERNAME}" "${DATABASE_NAME}"
  createdb -U "${USERNAME}" "${DATABASE_NAME}"
  pg_restore --clean --if-exists --exit-on-error --no-owner --schema=public --dbname="${DATABASE_NAME}" --username="${USERNAME}" "${1}"
} && {
  echo "Импорт успешно завершен."
} || {
  echo "Ошибка импортирования."
}
