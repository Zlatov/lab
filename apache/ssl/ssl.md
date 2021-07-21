
## Создание сертификата

См. файл ssl/mkcert_localhost/mkcert_localhost.md

## Установка модуля SSL для Apache

```sh
# Прежде, чем устанавливать модуль, выполняем команду:
apachectl -M | grep ssl
# Если видим строчку, на подобие:
ssl_module (shared)
# значит модуль SSL для Apache установлен

# Установка
# Для CentOS:
yum install mod_ssl
systemctl restart httpd
# Для Ubuntu/Debian:
a2enmod ssl
systemctl restart apache2
```

## Настройка Apache

```sh
# Редактируем виртуальный хост
<VirtualHost *:443>
    ServerName site.ru
    DocumentRoot /var/www/apache/data
    SSLEngine on
    SSLCertificateFile ssl/cert.pem
    SSLCertificateKeyFile ssl/cert.key
</VirtualHost>


# Проверяем корректность настроек в Apache:
apachectl configtest
# Перечитываем конфигурацию apache:
apachectl graceful
```

## Проверка работоспособности

Если сайт не заработал, пробуем найти причину по log-файлу. Как правило, он находится в каталоге /var/log/apache или /var/log/httpd.

## Настройка редиректа

```sh
# Редактируем виртуальный хост
<VirtualHost *:80>
    ServerName site.ru
    RewriteEngine On
    RewriteCond %{HTTPS} off
    RewriteRule (.*) https://%{HTTP_HOST}%{REQUEST_URI} [R=301,L]
</VirtualHost>
```

```sh
# В файле .htaccess
RewriteCond %{SERVER_PORT} ^80$
RewriteRule ^.*$ https://%{SERVER_NAME}%{REQUEST_URI} [R=301,L]
```

### Установка модуля rewrite

Чтобы перенаправление работало в Apache, необходимо установить модуль rewrite.

```sh
# а) в CentOS открываем конфигурационный файл:
vi /etc/httpd/conf.modules.d/00-base.conf
# и проверяем наличие строки? если ее нет, добавляем; если она закомментирована, снимаем комментарий.
LoadModule rewrite_module modules/mod_rewrite.so
# Перезапускаем
systemctl restart httpd

# б) в Ubuntu:
a2enmod rewrite
systemctl restart apache2
```
