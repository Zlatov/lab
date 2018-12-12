#!/usr/bin/env bash

set -eu

PGPASSWORD=lab psql -U lab -c "\c lab"
# PGPASSWORD=lab psql -U lab -c "CREATE DATABASE lab2;"
PGPASSWORD=lab psql -U lab -c "\c lab2"

# 
# после добавления в СУБД пользователя с именем текущего пользователя системы пропадает
# необходимость указывать пользователя перед утилитой psql (подробнее в user.sql) 
# 
