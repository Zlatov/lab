#!/bin/bash

# Если есть локальный конфиг - подключаем, установим пароль для mysql
if [ -f ./config.sh ]
    then
        . "./config.sh"
        export MYSQL_PWD="$DBPASS"
fi

mysql --host=$DBHOST --port=3306 --user="$DBUSER" --database="$DBNAME" -s < "./sql.sql" > 'text.txt'
