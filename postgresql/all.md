# Postgres

<!-- https://eax.me/postgresql-install/ Начало работы с PostgreSQL -->
<!-- https://postgrespro.ru/ -->

## Утсановка

`sudo apt-get install -y postgresql`


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
