-- dropdb -U lorem_rails lorem_rails --if-exists -W
-- createdb -U lorem_rails lorem_rails -W
-- createdb --encoding=UTF8 --locale=ru_RU.utf8 -U lorem_rails lorem_rails -W
-- или psql -U lorem_rails -d template1 -c "create database lorem_rails;"
-- sudo -u postgres psql -c "\l"

-- sudo -u postgres psql

DROP DATABASE IF EXISTS temp;
CREATE DATABASE temp;

DROP DATABASE IF EXISTS lab2;

-- 
-- Список баз данных
-- 
-- \l
-- или
-- SELECT datname FROM pg_database
-- WHERE datistemplate = false;
-- 
\l
SELECT datname FROM pg_database
WHERE datistemplate = false;

-- 
-- Текущая база дынных
-- 
SELECT current_database();

-- 
-- Переконнектиться к базе данных
-- 
-- postgres=# \c lab;
-- 
\c lab

-- Индексы в текущей базе данных
SELECT '> Индексы в текущей базе данных' as " ";
SELECT
  tablename,
  indexname,
  indexdef
FROM
  pg_indexes
WHERE
  schemaname = 'public'
ORDER BY
  tablename,
  indexname;
