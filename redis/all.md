# Redis

___Redis___ — NoSQL база данных со структурами данных типа «ключ — значение».

## Установка

```bash
sudo apt-get update
sudo apt-get install redis-server
# sudo apt-get install ruby-redis
sudo systemctl enable redis-server.service
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
