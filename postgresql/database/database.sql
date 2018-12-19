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
