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

`sudo systemctl restart redis-server.service`

`redis-cli`

```
> ping
PONG
```

```
redis-cli info
redis-cli info stats
redis-cli info server
```
