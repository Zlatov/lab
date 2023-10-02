
```sh
# 1. Заходим в запущенный контейнер;
docker compose exec web bash

# 2. Устанавливаем необходимые библиотеки;
# sudo apt-get install build-essential libcurl4-openssl-dev
apk add --no-cache curl-dev
bundle install

# 3. Выходим не завершая текущий процесс;
# [Ctrl+p, Ctrl+q]

# 4. Создать новый образ из контейнера;
# docker commit -m "{tag}" {container} {image}:{tag}
docker commit -m "latest" mini-light-web-1 gitlab.newstar.ru:5050/mini-light/mini-light/zenoweb/mini-light:latest

# 5. Проверить подключение
docker login gitlab.newstar.ru:5050

# 6. Запушить образ
# docker push {image}:{tag}
docker push gitlab.newstar.ru:5050/mini-light/mini-light/zenoweb/mini-light:latest

# 7. Переподнятие из нового изображения
docker compose stop web
docker compose down web
docker compose up web --no-start
docker compose start
```
