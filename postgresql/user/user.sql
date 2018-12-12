-- 
-- Список пользователей из баш
-- 
-- sudo -u postgres psql
-- \du
-- \q
-- 
-- или
-- 
-- sudo -u postgres psql -c "\du"
-- 

-- 
-- Менять тип авторизации пользователей
-- 
-- sudo subl /etc/postgresql/9.3/main/pg_hba.conf
-- Шаблон конфигурационной строки для настройки авторизации пользователей:
-- local     DATABASE  USER      METHOD  [OPTIONS]
-- Примеры:
-- local     all       root      md5
-- local     all       postgres  peer
-- local     lab,template1 lab   password
-- 

-- 
-- Немного про раздачу пользователей и прав
-- 
-- sudo -u postgres psql -c "…"
-- sudo -u postgres psql -c "CREATE USER test_user WITH password 'qwerty';"
-- sudo -u postgres psql -c "GRANT ALL ON DATABASE test_database TO test_user;"
-- sudo -u postgres psql -c "ALTER USER user_name WITH PASSWORD 'new_password';"
-- sudo -u postgres psql -c "ALTER USER lab CREATEDB;"
-- 
-- Следующая команда позволит второму пользователю управлять объектами созданными первым пользователем:
-- sudo -u postgres psql -c "grant lab to iadfeshchm;"
-- 

\l

SELECT
  u.usename AS "User name",
  u.usesysid AS "User ID",
  CASE
    WHEN u.usesuper AND u.usecreatedb THEN CAST('superuser, create database' AS pg_catalog.text)
    WHEN u.usesuper THEN CAST('superuser' AS pg_catalog.text)
    WHEN u.usecreatedb THEN CAST('create database' AS pg_catalog.text)
    ELSE CAST('' AS pg_catalog.text)
  END AS "Attributes"
FROM pg_catalog.pg_user u
ORDER BY 1;

\q
