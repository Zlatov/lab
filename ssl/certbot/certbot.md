## Установка

```bash
sudo yum install certbot
# ? надо ли
sudo yum install certbot python2-certbot-nginx
```

## Использование

```bash
sudo certbot certonly --webroot -w /var/www/test.losst.ru -d test.losst.ru -d www.test.losst.ru
# `--webroot -w /var/www/test.losst.ru` - путь который доступен с внешки

sudo certbot certonly --webroot -w /home/zlatov/app/market/public -d zenonline-zlatov-stage.klej.ru
sudo certbot certonly --webroot -w /home/zlatov/app/admin/public -d admin.zenonline-zlatov-stage.klej.ru
sudo certbot certonly --webroot -w /home/dan/app/zenonline/current/public -d newzenonline-dan-stage.klej.ru
sudo certbot certonly --webroot -w /home/zlatov/app/zenonline/current/public -d newzenonline-zlatov-stage.klej.ru
sudo certbot certonly --webroot -w /home/deployer/app/forum -d sign-forum.ru

# Добавился параметр --register-unsafely-without-email чтобы команда не
# приводила к ошибке при неуказании email адреса.
sudo certbot … --register-unsafely-without-email

# Удалить ключи для домена. Пред командой перенастроить nginx на работу без ключей.
sudo certbot delete --cert-name newzenonline.klej.ru
```

Пример настройки nginx с использованием фалов сертификата.

```bash

…

server {
    listen 91.238.11.30:80;
    server_name newzenonline-dan-stage.klej.ru;
    rewrite ^ https://newzenonline-dan-stage.klej.ru$request_uri? permanent;
}

…

server {
    listen 91.238.11.30:443 ssl;
    ssl_certificate /etc/letsencrypt/live/zenonline-zlatov-stage.klej.ru/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/zenonline-zlatov-stage.klej.ru/privkey.pem;

    …

    location / {
        proxy_set_header X-Forwarded-Proto https;

        …

    }
}
```
