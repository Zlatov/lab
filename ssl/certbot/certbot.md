
```bash
sudo certbot certonly --webroot -w /var/www/test.losst.ru -d test.losst.ru -d www.test.losst.ru
# `--webroot -w /var/www/test.losst.ru` - путь который доступен с внешки

sudo certbot certonly --webroot -w /home/zlatov/app/market/public -d zenonline-zlatov-stage.klej.ru
sudo certbot certonly --webroot -w /home/zlatov/app/admin/public -d admin.zenonline-zlatov-stage.klej.ru
sudo certbot certonly --webroot -w /home/dan/app/zenonline/current/public -d newzenonline-dan-stage.klej.ru
```



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