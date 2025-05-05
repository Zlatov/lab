# Как "курлиить" API

```sh
# GET Получить данные
curl http://example.com/api/resource
# POST Создать ресурс
curl -X POST -d '{"a":1}' URL
# PUT Полностью обновить ресурс
curl -X PUT -d '{"a":1}' URL
# PATCH Частично обновить ресурс
curl -X PATCH -d '{"a":1}' URL
# DELETE  Удалить ресурс
curl -X DELETE URL
```

# Часто используемые опции

```sh
-X METHOD          # — явно указать метод запроса (POST, PUT, DELETE, PATCH).
-d "key=value"     # — тело запроса.
-d '{"json":true}' # — тело запроса.
-H "Header: value" # — добавить заголовок (например, Content-Type или Authorization).
-s                 # — «тихий» режим (без прогресс-бара).
-v                 # — подробный вывод (debug).
-i                 # — показывать заголовки ответа.
-o file.json       # — сохранить ответ в файл.
-G                 # — использовать параметры в URL (для GET).
--data-urlencode   # — использовать параметры в URL (для GET).
-L                 # — следовать редиректам.
```


## GET

```sh
curl -G "http://localhost:3000/api/v1/products" \
  --data-urlencode "category=books" \
  --data-urlencode "sort=price"
# Или просто вручную:
curl "http://localhost:3000/api/v1/products?category=books&sort=price"
```


## POST
```sh
curl -X POST "http://localhost:3000/api/v1/orders" \
  -H "Content-Type: application/json" \
  -d '{"product_id":123,"quantity":2}'
```


## PUT

```sh
curl -X PUT "http://localhost:3000/api/v1/orders/1" \
  -H "Content-Type: application/json" \
  -d '{"product_id":123,"quantity":5}'
```


## PATCH

```sh
curl -X PATCH "http://localhost:3000/api/v1/orders/1" \
  -H "Content-Type: application/json" \
  -d '{"quantity":7}'
```


## DELETE

```sh
curl -X DELETE "http://localhost:3000/api/v1/orders/1"
```
