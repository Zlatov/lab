#!/usr/bin/env bash
exit 0

mysql -uroot -t -p <<- SQL
  SELECT User, Host, plugin FROM mysql.user;
  SELECT User, Host, plugin FROM mysql.user;
SQL
