# Установка кодировки UTF-8 по умолчанию в NGINX

В файле nginx.conf или в виртуальных хостах в директивах `http`, `server`, или
`location` дописываем строчку:

```sh
charset UTF-8;
```

Перезагружаем NGINX:

```sh
service nginx restart
```

Проверяем:

```sh
curl -I http://ya.ru # тут Ваш сайт
```

Ответ получим приблизительно такой:

```sh
HTTP/1.1 200 Ok
Server: nginx
Date: Tue, 17 Jun 2014 16:07:13 GMT
Content-Type: text/html; charset=UTF-8
Content-Length: 8223
Connection: close
Cache-Control: no-cache,no-store,max-age=0,must-revalidate
Expires: Tue, 17 Jun 2014 16:07:14 GMT
Last-Modified: Tue, 17 Jun 2014 16:07:14 GMT
P3P: policyref="/w3c/p3p.xml", CP="NON DSP ADM DEV PSD IVDo OUR IND STP PHY PRE NAV UNI"
Set-Cookie: yandexuid=6652202701403021234; Expires=Fri, 14-Jun-2024 16:07:13 GMT; Domain=.ya.ru; Path=/
X-Frame-Options: DENY
X-XRDS-Location: http://openid.yandex.ru/server_xrds/
```
