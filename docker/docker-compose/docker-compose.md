# docker-compose.yml

```yml
---
version: "3.8"

services:

  store_ruby:
    container_name: store_ruby
    build: .
    image: store_ruby:latest
    ports:
      - "3000:3000"
    volumes:
      - .:/usr/src/app

    # ?
    # links:
    #   - store_pg

    depends_on:
      - store_pg
      - store_redis

  # При соединении с postgres в контейнере store_ruby необходимо указывать host:
  # store_pg
  store_pg:
    container_name: store_pg
    image: postgres:14.6-alpine
    # На каком порту будет работать postgres
    expose:
      - "5432"
    # Проброс портов "снаружи:в_контейнере"
    ports:
      - "5432:5432"
    env_file:
      - ./variables.env
    # Необходимо создать файл .dockerignore с кодом volumes/ чтобы без ошибок
    # перебилживать с уже созданными томами.
    volumes:
      - ./volumes/pg_data:/var/lib/postgresql/data
      - ./volumes/pg_dump:/store/pg_dump
    # labels:
    #   description: Postgresql Database
    #   service: postgresql
    # networks:
    #   - default
    #   - service-proxy

  store_redis:
    container_name: store_redis
    image: redis:7.0.7
    ports:
      - "6380:6379"
    env_file:
      - ./variables.env

  es:
    image: elasticsearch:8.6.2
    # ports:
    #   - 9200:9200
    #   - 9300:9300
    environment:
      - discovery.type=single-node
      - xpack.security.enabled=false
    ulimits:
      memlock:
        soft: -1
        hard: -1
      nofile:
        soft: 65536
        hard: 65536
    deploy:
      resources: 
        limits: 
          cpus: "0.70"  # 0.50 - Use at most 50% of one CPU core
          memory: 1000M  # 50M - Use at most 500 MB of RAM
    # volumes:
    #   - ./volumes/es_data:/usr/share/elasticsearch/data

# volumes:
#   'volumes/pg_data': null
#   'volumes/pg_dump': null

# networks:
#   service-proxy:

```
