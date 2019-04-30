#!/usr/bin/env bash
set -eu

mysql -uroot -p <<- SQL
  DROP DATABASE IF EXISTS lab;
  CREATE SCHEMA lab DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;

  -- SET GLOBAL validate_password_length = 3;
  -- SET GLOBAL validate_password_mixed_case_count = 0;
  -- SET GLOBAL validate_password_number_count = 0;
  -- SET GLOBAL validate_password_special_char_count = 0;
  FLUSH PRIVILEGES;

  DROP USER IF EXISTS 'lab'@'localhost';
  DROP USER IF EXISTS 'lab'@'127.0.0.1';
  CREATE USER 'lab'@'localhost' IDENTIFIED BY 'lab';
  CREATE USER 'lab'@'127.0.0.1' IDENTIFIED BY 'lab';
  GRANT ALL ON lab.* TO 'lab'@'localhost';
  GRANT ALL ON lab.* TO 'lab'@'127.0.0.1';

  -- SET GLOBAL validate_password_length = 8;
  -- SET GLOBAL validate_password_mixed_case_count = 1;
  -- SET GLOBAL validate_password_number_count = 1;
  -- SET GLOBAL validate_password_special_char_count = 0;
  FLUSH PRIVILEGES;

  exit
SQL
