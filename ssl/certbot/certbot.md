## Установка

```bash
certbot --help
sudo apt install certbot
sudo yum install certbot
# ? надо ли
sudo yum install certbot python2-certbot-nginx
certbot --version
#> certbot 0.27.0
#> certbot 1.22.0
```

## Использование

```bash
# 1. Необходимо найти рельный путь публичной директории.
# 
# Возможно перелинкована certbot-овская директория (.well-known) или
# перелинкована сама «паблик» директория (public). А так же может быть
# перелинкован релиз проекта, так что всё зависит от конфигурации проекта.
# 
# Проверить:
ls -la ~/app/domain.name/current/public/.well-known
# и
ls -la ~/app/domain.name/current/public
# Определить реальный путь:
dirname $(realpath ~/app/domain.name/current/public/.well-known)
# или
realpath ~/app/domain.name/current/public


# 2. Генерировать ключи
sudo certbot certonly --register-unsafely-without-email --webroot -w /home/deployer/app/domain.name/shared/public -d domain.name
# /etc/letsencrypt/live/domain.name/fullchain.pem
# /etc/letsencrypt/live/domain.name/privkey.pem


# 3. Встроить ключи в nginx конфигурацию.
# 
# 443 конфигурация полностью дублирует 80 с изменениями, см. Пример настройки nginx
# 
# Перезагружаем nginx (из под root/sudo)
nginx -t
nginx -s reload


# 4. Обновить (продлить) сертификат
# 
# Сертификат действительно продляется в том случае если близка дата окончания
# сертификата, пишут что около 30 дней.
# 
# Посмотреть имена сертификатов (могут не совпадать с доменами):
certbot certificates
# Обновить, указав имя сертификата --cert-name
certbot renew --cert-name domain.name --dry-run
# Перезрузить nginx
nginx -t
nginx -s reload


# 5. Автоматическое обновление сертификатов
# Настроим крон, см. Пример crontab
crontab -l
EDITOR=mcedit crontab -e
# Настроим certbot хук, см. Пример certbot хука
touch /etc/letsencrypt/renewal-hooks/post/nginx-reload
mcedit /etc/letsencrypt/renewal-hooks/post/nginx-reload
chmod a+x /etc/letsencrypt/renewal-hooks/post/nginx-reload


# 6. Удалить сертификат для домена. Пред командой перенастроить nginx на работу без ключей.
# Посмотреть имена сертификатов (могут не совпадать с доменами):
certbot certificates
# Удалить
certbot delete --cert-name domain.name




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
```

Пример настройки nginx

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

Пример crontab

```bash
# Обновление ssl сертификатов, перегрузку nginx см. /etc/letsencrypt/renewal-hooks/post/nginx-reload
45 6 * * 0 certbot renew
```

Пример certbot хука

```bash
#!/usr/bin/env bash
systemctl reload nginx
```
