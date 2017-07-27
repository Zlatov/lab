#!/bin/bash

# Если есть локальный конфиг - подключаем, установим пароль для mysql
if [ -f ./config.sh ]
then
    . "./config.sh"
    export MYSQL_PWD="$DBPASS"
else
    echo 'Локальный конфиг не найден'
    exit 1
fi

if [ ! -f ./1.sql ]
then
    echo Файл 1.sql не найден
else
    if [ -f ./2.html ]
    then
        > 2.html
    fi
    mysql --host=$DBHOST --port=3306 --user="$DBUSER" --database="$DBNAME" -s < "./sql.sql" > 'text.txt'
fi

if [ ! -f ./2.sql ]
then
    echo Файл 2.sql не найден
else
    if [ -f ./2.html ]
    then
        > 2.html
    fi
    mysql --host=$DBHOST --port=3306 --user="$DBUSER" --database="$DBNAME" -s < "./2.sql" | while read post_id ex; do
    echo "id: $post_id"
    echo "<a href=\"https://sign-forum.ru/viewtopic.php?p=$post_id#p$post_id\">$post_id</a>" >> '2.html'
    done
fi
