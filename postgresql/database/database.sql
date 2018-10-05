-- sudo -u postgres psql

DROP DATABASE IF EXISTS temp;
CREATE DATABASE temp;

DROP DATABASE IF EXISTS lab2;

-- 
-- Список баз данных:
\l

-- Переконнектиться к базе данных:
-- postgres=# \c lab;
-- 

-- SELECT datname FROM pg_database
-- WHERE datistemplate = false;
