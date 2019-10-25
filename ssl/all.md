# SSL

## Получение самоподписанного сертификата


`openssl genrsa -out rootCA.key 2048`


`openssl req -x509 -new -nodes -key rootCA.key -sha256 -days 1024 -out rootCA.pem`


https://habr.com/ru/post/352722/
https://gist.github.com/croxton/ebfb5f3ac143cd86542788f972434c96
http://oddstyle.ru/veb-razrabotka/kak-ustanovit-https-lokalno-bez-nadoedlivyx-uvedomlenij-v-brauzere.html
https://www.leaderssl.ru/articles/207-vse-pro-openssl-za-5-minut

Выпуск верифицированного сертификата бесплатно: https://letsencrypt.org/ru
