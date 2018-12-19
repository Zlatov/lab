#!/usr/bin/env bash

set -eu

PGPASSWORD=lab psql -U lab -c "\c lab"
# PGPASSWORD=lab psql -U lab -c "CREATE DATABASE lab2;"
PGPASSWORD=lab psql -U lab -c "\c lab2"

# 
# после добавления в СУБД пользователя с именем текущего пользователя системы пропадает
# необходимость указывать пользователя перед утилитой psql (подробнее в user.sql) 
# 

# Часто используемые параметры
# -h, --host=HOSTNAME      database server host or socket directory (default: "/var/run/postgresql")
# -p, --port=PORT          database server port (default: "5432")
# -U, --username=USERNAME  database user name (default: "iadfeshchm")
# -w, --no-password        never prompt for password
# -W, --password           force password prompt (should happen automatically)

exit 0
PGPASSWORD=$LOREM_RAILS_PSQL_PASSWORD dropdb -U lorem_rails lorem_rails
PGPASSWORD=$LOREM_RAILS_PSQL_PASSWORD createdb -U lorem_rails lorem_rails
PGPASSWORD=$LOREM_RAILS_PSQL_PASSWORD psql -U lorem_rails -d template1 -c "create database lorem_rails;"
