#!/usr/bin/env bash

set -eu

cd "$(dirname "${0}")"

. ../../bash/_lib/echoc

. ~/.bashrc-env

# Список пользователей.
mysql -uroot -t <<< "SELECT User, Host, plugin FROM mysql.user;"

exit 0

# Добавить пользователя.
mysql -uroot "CREATE USER 'userLogin'@'localhost' IDENTIFIED BY 'userPassword';"