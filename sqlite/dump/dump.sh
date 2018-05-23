#!/bin/bash

# Создание бд и наполнение командами из файла
sqlite3 db.sqlite3 < create.sql

# В CSV
sqlite3 db.sqlite3 <<!
.headers on
.mode csv
.output dump.csv
select * from a;
.exit
!

# В SQL
sqlite3 db.sqlite3 <<!
.output dump.sql
.dump a
.quit
!

# Восстановить из дампа
sqlite3 db.sqlite3 'DROP TABLE a;'
sqlite3 db.sqlite3 < dump.sql
