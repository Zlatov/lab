# Локали кластера

## Установка новых локалей

1. Необходимо проверить установленные локали

```bash
locale -a
#> en_AU.utf8
#> ...
#> POSIX
```

2. Сгенерировать новую локаль ru_RU.UTF-8

```bash
locale-gen ru_RU.UTF-8
#> Generating locales (this might take a while)...
#>   ru_RU.UTF-8... done
#> Generation complete.
```

3. Сконфигурировать локаль

```bash
dpkg-reconfigure locales
```

4. Посмотреть установленные локали

```bash
locale -a
#> C.UTF-8
#> en_AU.utf8
#> ...
#> POSIX
#> ru_RU.utf8
#> ...
```


## Пересоздать кластер с учётом локали

5. Посмотреть версию кластера

```bash
pg_lsclusters
#> Ver Cluster Port Status Owner    Data directory               Log file
#> 9.5 main    5432 online postgres /var/lib/postgresql/9.5/main /var/log/postgresql/postgresql-9.5-main.log
#> Здесь версия 9.5 название main
```

6. Удалить кластер

```bash
pg_dropcluster --stop 9.5 main
#> Redirecting stop request to systemctl
```

7. Создать новый кластер

```bash
pg_createcluster --locale ru_RU.utf8 --start 9.5 main
#> Creating new cluster 9.5/main ...
#>   config /etc/postgresql/9.5/main
#>   data   /var/lib/postgresql/9.5/main
#>   locale ru_RU.utf8
#>   socket /var/run/postgresql
#>   port   5432
#> Redirecting start request to systemctl
```
