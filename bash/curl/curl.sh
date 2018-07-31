# !/usr/bin/env bash

# curl --write-out %{http_code} --output /dev/null localhost:3031/cat/#{model.slug}

curl -L lab.local/bash
# заставляет cURL следовать за любым переходом на указанной странице

curl -u name:password https://mail.google.com/gmail/feed/atom
# передаёт cURL имя пользователя и пароль, что позволяет пройти авторизацию

# Документация от Шведских хакеров по cURL:
# https://curl.haxx.se/docs/httpscripting.html


curl http://proft.me
# получаем содержания главной страницы

curl -o index.html http://proft.me
# получаем содержания главной страницы в файл index.html

curl -L http://example.com
# при получении содержимого страницы следовать по редиректам (если такие есть)

curl -u username:password http://example.com/login/
# получение страницы скрытой за Basic HTTP Authentication

curl -x proxy.com:3128 http://proft.me
# получение страницы используя прокси

curl -I proft.me
# получаем http-заголовки с сайта

curl -H 'Host: google.ru' http://proft.me
# подменить домен при обращении к серверу (передача своего заголовка)

curl --request POST "http://example.com/form/" --data "field1=value1&field2=value2"
# передача данных POST-запросом

curl -X POST "http://example.com/form/" --data "field1=value1&field2=value2"
# передача данных POST-запросом

curl -X POST -H "Content-Type: application/json" -d '"title":"Commando","year":"1985"' http://example.com/api/movies/
# передача данных POST-запросом, данные в виде JSON

curl --request PUT "http://example.com/api/movie/1/" --data "title=DjangoUnchained"
# передача данных PUT-запросом

curl -F uploadfiled=@file.zip -F submit=OK http://example.com/upload/
# загрузка файла file.zip в форму (multipart/form-data)

curl -u username:password -O ftp://example.com/file.zip
# скачать файл с FTP

curl -u username:password -T file.zip ftp://example.com/
# закачать файл по FTP

curl --cookie "login=proft" http://example.com/login/
# установить кукис

curl --cookie-jar cookies.txt http://example.com
# сохранение кукисов в файл

curl --cookie cookies.txt http://example.com/login/
# использование сохраненных кукисов
