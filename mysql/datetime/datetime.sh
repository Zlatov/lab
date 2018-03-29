#!/bin/bash
. ../../bash/_lib/echoc
. ../common.sh

echoc 'Работа с датой и временем в mysql' red

mysql -t < ./table.sql
mysql -t <<SQL
USE lab;
SELECT * FROM test;
SQL
mysql -te "USE lab;SELECT * FROM test;"

# echo $?
# exit 0
