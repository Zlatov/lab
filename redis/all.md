# Redis

___Redis___ — NoSQL база данных со структурами данных типа «ключ — значение».

## Установка

```bash
# Ubuntu
sudo apt-get update
sudo apt-get install redis-server
# sudo apt-get install ruby-redis
sudo systemctl enable redis-server.service

# Centos
# 1. Из epel репозитория (установилась старая версия, на 7 центосе)
sudo yum install epel-release
sudo yum update
sudo yum install redis
sudo systemctl start redis
sudo systemctl enable redis
# 2. Из remi репозитория
# 2.1 Установка реми
sudo yum -y update # обновить центос
sudo yum -y install http://rpms.remirepo.net/enterprise/remi-release-7.rpm # добавляем реми в систему
# 2.2 Установка redis 
sudo yum --enablerepo=remi install redis
# Проверить версию
rpm -qi redis
redis-server --version
```

`sudo nano /etc/redis/redis.conf`

```bash
# file /etc/redis/redis.conf
maxmemory 256mb
maxmemory-policy allkeys-lru
```

```sh
sudo systemctl enable --now redis
sudo systemctl status redis.service
sudo systemctl restart redis.service

# Проверка
telnet localhost 6379
> ping
# +PONG
# ^] Ctrl+d

# Проверка локально-установленной консольной утилиты
redis-cli
> ping
PONG
# Ctrl+d

# Просмотр настроек и статистики
redis-cli info
redis-cli info stats
redis-cli info server
```
