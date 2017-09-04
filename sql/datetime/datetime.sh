#!/bin/bash
. ../../bash/_lib/colorize
. ../common.sh

echo -en $COLOR_BLUE
echo -e 'Работа с датой и временем в mysql'
echo -en $COLORIZE_CLEAR

mysql -t < ./table.sql
mysql -t <<SQL
USE lab;
SELECT * FROM test;
SQL

# echo $?
# exit 0
