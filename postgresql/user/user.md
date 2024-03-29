## Список пользователей из баш

`sudo -u postgres psql -c "\du"`


## Добавление пользователей в систему, настройка типа авторизации пользователей

`sudo mcedit /etc/postgresql/10/main/pg_hba.conf`
или в другом месте, узнать место конфигов выполнив одну из команд:
`psql -U postgres -c 'SHOW config_file'`
`sudo -u postgres psql -c 'SHOW config_file'`

__Шаблон конфигурационной строки для настройки авторизации пользователей__:

```bash
# TYPE  DATABASE        USER            ADDRESS                 METHOD
```

__Примеры__ (вместо `local all all peer` установить необходимое):

```bash
local   all             iadfeshchm                              md5
```

А если нужно ограничить то добавить доступ к базовым базам данным и шаблонам:

```bash
local   project         project                                 md5
local   postgres        project                                 md5
local   template0       project                                 md5
local   template1       project                                 md5
```

Для лаборатории конечно незабыть добавить

```bash
local   lab             lab                                     password
local   postgres        lab                                     password
local   template0       lab                                     password
local   template1       lab                                     password
```

Получилось разрешить из докера работать с локальным сервером постгрес так:

```bash
# /etc/postgresql/12/main/postgresql.conf
listen_addresses = '*' # Заставить прослушивать все
# /etc/postgresql/12/main/pg_hba.conf
host all user_name 127.0.0.1/32 md5 # Это старая настройка работы через localhost
host all user_name 172.0.0.1/8  md5 # Это настройка ссумируется с предыдущей
                                    # позволила работать из докер-контейнера 172.23.0.6
```


__Типы авторизации__

* `trust` – Безусловно разрешает все подключения. Этот метод разрешает любому, кто может подключиться к серверу БД, зайти под любым пользователем PostgreSQL без необходимости предоставить пароль или использования какого-либо ещё способа аутентификации.
* `reject` – Безусловно отклоняет подключение. Это полезно для “отфильтровывания” некоторых узлов из группы, например строка reject может запретить конкретному узлу подключение, тогда как следующая строка разрешает подключения для остальных узлов этой сети.
* `md5` – Требует от клиента предоставить md5 шифрованный пароль для аутентификации.
* `password` – Требует от клиента предоставить незашифрованный пароль для аутентификации. Так как пароль посылается по сети в открытом виде, эта опция не должна использоваться для небезопасных сетей.
* `gss` – Использует GSSAPI для аутентификации пользователя. Доступно только для TCP/IP подключений.
* `sspi` – Использует SSPI для аутентификации пользователя. Доступно только для Windows.
* `krb5` – Использует Kreberos V5 для аутентификации пользователя. Доступно только для TCP/IP подключений.
* `ident` – Получает имя пользователя ОС клиента, соединяясь с сервером ident на клиенте и проверяет, соответствует ли оно имени пользователя для запрашиваемой БД. Аутентификация ident может использоваться только на TCP/IP соединениях. Когда это значение используется для локальных соединений, то вместо этого используется peer аутентификация.
* `peer` – Получает имя пользователя ОС из самой ОС и проверяет, соответствует ли оно имени пользователя для запрашиваемой БД. Доступно только для локальных подключений.


## Немного про раздачу прав пользователям

```bash
sudo -u postgres psql -c "CREATE USER username WITH password 'password';"
sudo -u postgres psql -c "ALTER USER username CREATEDB;"
sudo systemctl restart postgresql
sudo service postgresql restart

sudo -u postgres psql -c "ALTER USER postgres WITH PASSWORD 'not_empty_password';"

sudo -u postgres psql -c "DROP USER username;"

sudo -u postgres psql -c "ALTER ROLE deploy SUPERUSER;"
sudo -u postgres psql -c "ALTER ROLE deploy NOSUPERUSER;"
```

```bash
# Следующее даст не все:
sudo -u postgres psql -c "GRANT ALL ON DATABASE database_name TO username;"

# Нужно грандиьт таблицы:
sudo -u postgres psql -c "GRANT ALL PRIVILEGES ON TABLE table_name TO username;"

# Грандим все таблицы:
sudo -u postgres psql
\c database_name;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO username;

# Смена пароля
sudo -u postgres psql -c "ALTER USER username WITH PASSWORD 'new_password';"

# Позволит второму пользователю управлять объектами созданными первым пользователем:
sudo -u postgres psql -c "grant lab to iadfeshchm;"

# Список баз с их кодировками и владельцами
sudo -u postgres psql -c "\l"
```

```sql
-- Пользователи и их права
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
```

## Восстановление прав имея sudo

1. Находим pg_hba.conf
2. Добавляем в начало строку
```sh
local  all   all   trust
# или
host  all   all  127.0.0.1/32  trust
```
3. Перезапускаем сервис
```sh
systemctl | grep postgres
systemctl restart postgresql-12
```
4. Делаем всё что хотим (меняем пароль или даём права)
```sh
psql -U postgres
# или
psql -h 127.0.0.1 -U postgres
```
5. Возвращаем обратно конфиг и ещё раз рестартим.
