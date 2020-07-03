#!/usr/bin/env bash

set -eu

cd "$(dirname "${BASH_SOURCE[0]}")"

. ../_lib/mysql.sh

echo "Начинаем выполнение инструкциямй в mysql/procedures."

ls ../../mysql/procedures | xargs -I {} cat ../../mysql/procedures/{} | mysql --user="${MYSQL_USERNAME}" --host="${MYSQL_HOST}" --database="${DATABASE_NAME}"

echo "Done."
