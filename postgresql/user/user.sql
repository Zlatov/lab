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
-- Добавлять пользователей в систему, настраивать тип авторизации пользователей
-- 
-- sudo subl -n /etc/postgresql/9.3/main/pg_hba.conf
-- Шаблон конфигурационной строки для настройки авторизации пользователей:
-- local     DATABASE  USER      METHOD  [OPTIONS]
-- Примеры:
-- local     all       root      md5
-- local     all       postgres  peer
-- local     lab,template1 lab   password
-- 

-- trust – Безусловно разрешает все подключения. Этот метод разрешает любому, кто может подключиться к серверу БД, зайти под любым пользователем PostgreSQL без необходимости предоставить пароль или использования какого-либо ещё способа аутентификации.
-- reject – Безусловно отклоняет подключение. Это полезно для “отфильтровывания” некоторых узлов из группы, например строка reject может запретить конкретному узлу подключение, тогда как следующая строка разрешает подключения для остальных узлов этой сети.
-- md5 – Требует от клиента предоставить md5 шифрованный пароль для аутентификации.
-- password – Требует от клиента предоставить незашифрованный пароль для аутентификации. Так как пароль посылается по сети в открытом виде, эта опция не должна использоваться для небезопасных сетей.
-- gss – Использует GSSAPI для аутентификации пользователя. Доступно только для TCP/IP подключений.
-- sspi – Использует SSPI для аутентификации пользователя. Доступно только для Windows.
-- krb5 – Использует Kreberos V5 для аутентификации пользователя. Доступно только для TCP/IP подключений.
-- ident – Получает имя пользователя ОС клиента, соединяясь с сервером ident на клиенте и проверяет, соответствует ли оно имени пользователя для запрашиваемой БД. Аутентификация ident может использоваться только на TCP/IP соединениях. Когда это значение используется для локальных соединений, то вместо этого используется peer аутентификация.
-- peer – Получает имя пользователя ОС из самой ОС и проверяет, соответствует ли оно имени пользователя для запрашиваемой БД. Доступно только для локальных подключений.

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
