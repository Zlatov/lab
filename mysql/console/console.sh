#!/usr/bin/env bash

set -eu

. ~/.bashrc-env

mysql -uroot -t -p$MYSQL_PWD <<- SQL
  SELECT User, Host, plugin FROM mysql.user;
SQL

mysql --database="$DBNAME" --user="$DBUSER" --password="$DBPASS" -e "UPDATE forum_config SET config_value = 'sign-forum.local' WHERE config_name = 'cookie_domain';"

# -t, --table         Output in table format.
# -p, --password[=name] 
#                     Password to use when connecting to server. If password is
#                     not given it's asked from the tty.
