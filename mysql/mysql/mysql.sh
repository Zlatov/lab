#!/usr/bin/env bash

set -eu

exit 0

set -a
MYSQL_PWD=password
set +a

mysql --user="${MYSQL_USERNAME}" --host="${MYSQL_HOST}" --database="${DATABASE_NAME}" < "$1"

mysql -uroot -t -p$MYSQL_PWD <<- SQL
  SELECT User, Host, plugin FROM mysql.user;
SQL

mysql --database="$DBNAME" --user="$DBUSER" --password="$DBPASS" -e "UPDATE forum_config SET config_value = 'sign-forum.local' WHERE config_name = 'cookie_domain';"

# 
# -t, --table         Output in table format.
# -p, --password[=name] 
#                     Password to use when connecting to server. If password is
#                     not given it's asked from the tty.
# 
# Восстановление из мультидампа:
# mysql --one-database …
# 
# Отключить слежение за внешними ключами при импорте:
# mysql --init-command="SET SESSION FOREIGN_KEY_CHECKS=0;" …
# 
