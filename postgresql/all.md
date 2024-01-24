# Postgres

<!-- https://eax.me/postgresql-install/ Начало работы с PostgreSQL -->
<!-- https://postgrespro.ru/ -->


## Определить установленную версию version

```sh
postgres --version
postgres -V
# Если команда postgres не найдена
locate bin/postgres
/usr/pgsql-9.6/bin/postgres --version
#> postgres (PostgreSQL) 9.6.24

systemctl | grep postgresql
systemctl status postgresql

sudo -u postgres psql
SELECT version();
SHOW server_version;

# sudo apt install postgresql-client
psql --version
psql -V
locate bin/psql
```


## Утсановка

```sh
# Елси просто последняя версия
sudo apt update
sudo apt-get install -y postgresql

# Если нужна конкретная версия
# https://www.postgresql.org/download/linux/ubuntu/
# Create the file repository configuration:
sudo sh -c 'echo "deb https://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
# Import the repository signing key:
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
# Update the package lists:
sudo apt-get update
# Install the latest version of PostgreSQL.
# If you want a specific version, use 'postgresql-12' or similar instead of 'postgresql':
# sudo apt-get -y install postgresql

apt-cache pkgnames postgresql | grep 9.6
sudo apt-get -y install postgresql-9.6
systemctl | grep postgresql
systemctl status postgresql

# Если нужно увеличить версию psql, pg_dump, pg_restore
# Устанаваливаем пакет postgresql-client-14
apt-cache pkgnames postgresql | grep 14
sudo apt-get -y install postgresql-client-14
# Ищем бинарники пакета
locate bin/psql
# В файл .bashrc изменяем переменную PATH так, чтобы пути к новым бинарникам были в начале
export PATH="/usr/lib/postgresql/14/bin:$PATH"
```


## Кофигурирование

`/etc/postgresql/9.3/main/postgresql.conf` — конфигурационный файл.


## Доп. ПО

vstudio (Valentina Studion) — GUI редактор.


## Консоль

`sudo -u postgres psql`
`\q` + __Enter__ — выйти из psql


### Старт/Рестарт/Стоп

`sudo service postgresql status`
`sudo service postgresql restart`


### Дамп

`pg_dump -c -h 192.168.0.1 -U test_user test_database > ./dump.sql`
`cat dump.sql | psql -h 192.168.0.1 test_database test_user`


### psql

`psql -h your-server-name -U your-username -d your-database-name -p we-could-have-a-port-as-well -c "select count(*) from your_table;"`
`psql -h localhost test_database test_user`
`psql -h localhost` — войти под тем же пользователем из под которого запущена консоль (имеется в виду имя пользователя).

## Обновление до 12 версии на убунту

1.   Убунту фиксирует версию PG и не обновляет самостоятельно, для обновления версии необходимо добавить PostgreSQL Apt Repository по иструкции https://www.postgresql.org/download/linux/ubuntu/ и выполнить `sudo apt-get -y install postgresql-12`
2.   Обновить кластер существующей версии с помощью команд (пердварительно остановив сервис):

```sh
# Посмотреть список существующих кластеров
pg_lsclusters

# Переименовать новый пустой кластер, чтобы при обновлении старого кластера имена не конфликтовали.
sudo pg_renamecluster 12 main main_pristine

# Команда обновления старого кластера
sudo pg_upgradecluster 10 main

# После того как вы убедились!!! что всё работает - можно удалить стаый кластер.
sudo pg_dropcluster 10 main
```
