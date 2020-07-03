#!/usr/bin/env bash

set -eu

cd "$(dirname "${0}")"

. ../../bash/_lib/echoc

. ~/.bashrc-env

# Список пользователей.
mysql -uroot -t -p <<< "SELECT User, Host, plugin FROM mysql.user;"

exit 0

# Добавить пользователя.
mysql -uroot -p <<< "CREATE USER 'userLogin'@'localhost' IDENTIFIED BY 'userPassword';"

# Добавить пользователя lab и его бд.
mysql -uroot -p <<< "CREATE USER 'lab'@'localhost' IDENTIFIED BY 'lab';"
mysql -uroot -p <<< "GRANT ALL ON lab.* TO 'lab'@'localhost';"
mysql -uroot -p <<< "GRANT ALL ON lab2.* TO 'lab'@'localhost';"
mysql -uroot -p <<< "FLUSH PRIVILEGES;"
mysql -ulab -plab <<< "CREATE SCHEMA lab DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;"
mysql -ulab -plab <<< "CREATE SCHEMA lab2 DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;"
