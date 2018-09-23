#!/usr/bin/env bash
exit 0

mysq -uroot -t -p <<- SQL
  SELECT User, Host, plugin FROM mysql.user;
  SELECT User, Host, plugin FROM mysql.user;
SQL
