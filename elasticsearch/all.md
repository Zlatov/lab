# elasticsearch

## Установка с docker

```sh
docker pull elasticsearch:8.4.1
docker run -d --name es8 -p 9020:9200 -p 9030:9300 -e "discovery.type=single-node" -e "xpack.security.enabled=false" elasticsearch:8.4.1
docker exec -it es8 bash
curl -X GET "localhost:9200"
# Ctrl + p + q
curl -X GET "localhost:9020"
```

## Установка в систему

Там и java нужна определённой версии, в общем жесть - читать внимательно ставить только нужное:

1. Определиться с нужной версией (6 и 7 не совместимы, посмотреть какую юзает приложение!!!)

Проверка версии установленной версии:

```sh
curl -X GET "localhost:9200"
curl -XGET 'http://localhost:9200'
```

__Установка 6.8 версии:__

```sh
# Удаление 7 версии
sudo su
systemctl stop elasticsearch
systemctl status elasticsearch
systemctl disable elasticsearch
systemctl daemon-reload
apt --purge remove elasticsearch
rm -rf /var/lib/elasticsearch
rm /etc/apt/sources.list.d/elastic-7.x.list

cd
apt-get install openjdk-8-jdk
java -version
wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
apt install apt-transport-https
echo "deb https://artifacts.elastic.co/packages/6.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-6.x.list
apt update && apt install elasticsearch
mcedit /etc/elasticsearch/elasticsearch.yml
network.host: 0.0.0.0
systemctl enable elasticsearch
systemctl daemon-reload
systemctl status elasticsearch

```

__Установка 7 версии:__

Скачать, установить (
  deb: https://www.elastic.co/guide/en/elasticsearch/reference/current/deb.html
  ```sh
  sudo apt-get update && sudo apt-get install elasticsearch
  ```
  или
  ```sh
  wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-7.14.1-amd64.deb
  wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-7.14.1-amd64.deb.sha512
  shasum -a 512 -c elasticsearch-7.14.1-amd64.deb.sha512 
  sudo dpkg -i elasticsearch-7.14.1-amd64.deb

  sudo /bin/systemctl daemon-reload
  sudo /bin/systemctl enable elasticsearch.service

  sudo systemctl status elasticsearch
  ```
) и зпустить:

Отредактируйте `/etc/elasticsearch/elasticsearch.yml` и добавьте следующую строку:
```bash
network.host: 0.0.0.0
```

Если будет нужно!!!:
```bash
# mcedit /etc/default/elasticsearch
JAVA_HOME=/usr/bin/java
```


При переустановке (даунгрейде) эластика позаботится об удаленнии вручную каталога `/var/lib/elasticsearch`, а то можно потерять пару часов на этот бред. Твари.


```bash
sudo systemctl start elasticsearch
sudo systemctl enable elasticsearch # запускался при старте сервера
sudo systemctl status elasticsearch
```

__проверка, версия__

```bash
curl http://localhost:9200/_cluster/health?pretty
curl -X GET "localhost:9200"
```

## Проверка в докер контейнере

```sh
docker compose exec es bash
curl -X GET "localhost:9200"
# Индексы
curl localhost:9200/_cat/indices
# Удалить индекс/индексы (через запятую)
curl -X DELETE http://localhost:9200/users_development_20230706135438618,posts_development_20230706135438618
```

## Elasticsearch и ruby-приложение

Гем `gem install elasticsearch`, репозиторий https://github.com/elastic/elasticsearch-ruby


## Просмотр статуса ES

docker compose exec es bash

```bash
# Кластер (Cluster)
# можно сказать что это сервис, может работать на нескольких нодах
# (контейнерах), посмотреть кластер:
curl -XGET 'localhost:9200/_cluster/health?pretty'

# Нода (Node)
# Один запущенный экземпляр Elasticsearch (обычно контейнер или процесс).
# Посмотреть ноды кластера:
curl -XGET 'localhost:9200/_cat/nodes?v'

# Индекс (Index)
# Логическая "коллекция документов", индекс разбивается на шарды. Список
# индексов:
curl -XGET 'localhost:9200/_cat/indices?v'
# включая системные индексы, например, .geoip_databases:
curl -X GET "localhost:9200/_cat/indices?v&s=store.size:desc&expand_wildcards=all"
# Удалить индекс:
curl -XDELETE 'localhost:9200/my_index'

# Документ (Document)
# Запись, объект в индексе, как строка в таблице или JSON-файле. Пример запроса
# документа по ID:
curl -XGET 'localhost:9200/product/_doc/123'

# Шард (Shard)
# Физическая часть индекса, в которой реально хранятся данные. Шарды:
curl -XGET 'localhost:9200/_cat/shards?v'

# Реплика (Replica)
# 
# Копия primary-шарда для отказоустойчивости. Elasticsearch сам решает, куда
# положить реплики. Если у тебя одна нода, то реплики невозможно аллоцировать →
# проблемы. Изменить число реплик у индекса:
curl -XPUT 'localhost:9200/my_index/_settings' -H 'Content-Type: application/json' -d '{
  "index": {
    "number_of_replicas": 0
  }
}'

# UNASSIGNED Шард
# 
# Шард есть, но ни одна нода не может его «взять на себя». Причина может быть:
# нехватка места, 1 нода и 1 реплика, падение или удаление старой ноды.
# почему не аллоцируется:
curl -XGET 'localhost:9200/_cluster/allocation/explain?pretty' \
  -H 'Content-Type: application/json' \
  -d '{
    "index": "my_index",
    "shard": 0,
    "primary": true
}'

# Информация о дисках (fs)
curl -XGET 'localhost:9200/_nodes/stats/fs?pretty'
# Текущие настройки кластера
curl -XGET 'localhost:9200/_cluster/settings?pretty'
curl -s -X GET 'localhost:9200/_cluster/settings?pretty'

# Установить менее требовательные лимиты к жесткому диску (временное решение).
# persistent - сохраняются между перезапусками кластера
# transient - теряются при перезапуске
curl -X PUT "localhost:9200/_cluster/settings" -H 'Content-Type: application/json' -d'
{
  "persistent": {
    "cluster.routing.allocation.disk.watermark.low": "92%",
    "cluster.routing.allocation.disk.watermark.high": "95%",
    "cluster.routing.allocation.disk.watermark.flood_stage": "98%"
  }
}
'
```

```yml
  es:
    image: .../elasticsearch:8.6.2
    # ports:
    #   - 9200:9200
    #   - 9300:9300
    environment:
      # Режим работы Elasticsearch как одиночного узла (без кластера)
      - discovery.type=single-node
      # Отключает встроенную аутентификацию и безопасность для упрощения разработки
      - xpack.security.enabled=false
      # У Elasticsearch есть встроенный функционал для автоматического
      # обновления GeoIP баз данных. Эти базы хранятся в специальном системном
      # индексе с именем .geoip_databases. Настройка отключает встроенный
      # функционал обновления:
      - ingest.geoip.downloader.enabled=false
    # Папка ./volumes/es_data должна принадлежать пользователю 1000:1000, чтобы
    # внутрений пользователь контейнера elasticsearch имел к ней доступ.
    # sudo chown -R 1000:1000 ./volumes/es_data
    # sudo chmod -R 755 ./volumes/es_data
    user: "1000:1000"
    deploy:
      resources:
        limits:
          # Ограничение CPU: контейнер может использовать не более 70% одного ядра CPU.
          # Если нужно больше - увеличить до "1.0" или "2.0"
          cpus: "0.70"
          # Ограничение оперативной памяти: контейнер может использовать не более 1 ГБ RAM.
          # Elasticsearch важно иметь достаточно памяти для кэширования и работы JVM.
          # При нехватке памяти могут возникать ошибки OutOfMemoryError
          memory: 1000M
    volumes:
      # Монтирование директории для сохранения данных Elasticsearch между перезапусками.
      # Без этого volume все данные будут теряться при перезапуске контейнера!
      - ./volumes/es_data:/usr/share/elasticsearch/data
    restart: unless-stopped
```
