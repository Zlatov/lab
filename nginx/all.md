# Nginx

## Установка

```sh
sudo apt-get purge nginx nginx-common nginx-full

sudo apt update && sudo apt install -y nginx
```

## Остановка, запуск, статус

```sh
# Проверить кофигурацию:
sudo nginx -t
# Перезапустить конфигурационный файл без перезагрузки Nginx:
sudo nginx -s reload

sudo service nginx stop
sudo service nginx start
sudo service nginx restart
sudo service nginx reload
sudo service nginx status

sudo systemctl stop nginx
sudo systemctl start nginx
sudo systemctl restart nginx
systemctl status nginx
```


## Настойки

### Настойки права пользователя из-под которого запущен nginx

```bash
# Пользователь nginx должен присутствовать в группе пользователя у которого
# лежит приложение.
sudo usermod -a -G <group> <user>
sudo usermod -a -G deployer www-data
# Добавить пользователя deployer в группу fpm (не знаю зачем)
sudo usermod -a -G fpm deployer
# Проверить право nginx-пользователя на доступ к файлам приложения.
sudo -u nginx stat /home/deployer/app/name
# Зачастую нехватает +x прав на корневые каталоги пользователя.
chmod g+x /home/
chmod g+x /home/username
# Пользователь nginx должен присутствовать в группе пользователя fpm.
sudo usermod -a -G fpm nginx
# Проверить (показать Группы в которых состоит пользователь nginx)
id -Gn nginx
groups nginx
# Проверить имет ли право nginx-пользователь читать файл.
su <nginx-user> -s /bin/bash -c 'if [ -r <path-to-html-file> ]; then echo "Readable"; else echo "Invalid permissions"; fi'
# Удалить пользователя из группы
gpasswd --delete user group
```


### Настройка виртуальных хостов

`sudo touch /etc/nginx/sites-available/nginx.local.conf`
`subl /etc/nginx/sites-available/nginx.local.conf`
`subl /etc/nginx/sites-available/default`

```bash
server {
  # listen 8080 default_server;
  # listen [::]:8080 default_server ipv6only=on;
  listen 8087;
  listen [::]:8087;
  charset UTF-8;

  root /home/iadfeshchm/projects/my/nginx;
  index index.html index.htm;

  server_name nginx.local www.nginx.local;

  location / {
    try_files $uri $uri/ =404;
  }
}
server {
    # listen 127.0.0.1:8000;
    # listen 127.0.0.1;
    # listen 8000;
    # listen *:8000;
    # listen localhost:8000;
    # listen [::]:8000;
    # listen [::1];
    # listen unix:/var/run/nginx.sock;
    listen *:80;

    server_name lorem_rails.ihor, www.lorem_rails.ihor;
    client_max_body_size 256m;
    location / {
        # auth_basic "Authentificate, please";
        # auth_basic_user_file /etc/nginx/conf.d/market_admin/.htpasswd;
        proxy_pass http://127.0.0.1:48888;
        proxy_set_header Host $host;
        proxy_set_header X-Forwarded-For $remote_addr;
        port_in_redirect off;
        proxy_connect_timeout 600;
        proxy_read_timeout 600;
        fastcgi_read_timeout 600s;
    }
}
```

`sudo rm /etc/nginx/sites-enabled/default`

`sudo ln -s /etc/nginx/sites-available/nginx.local.conf /etc/nginx/sites-enabled/nginx.local.conf`

В файле `subl /etc/nginx/nginx.conf` раскомментируем: `server_names_hash_bucket_size 64;`

`sudo service nginx restart`

`subl /var/log/nginx/error.log` =)

В файл `subl /etc/hosts` добавим `127.0.0.1 nginx.local www.nginx.local`

_И не забыть что мы бываем за прокси…_


### FPM

_/etc/php5/fpm/pool.d/forum.conf_:

```
[forum]
;prefix = /path/to/pools/$pool
user = fpm
group = fpm
listen = /var/run/php5-fpm-forum.sock
;listen.backlog = 65535
listen.owner = fpm
listen.group = fpm
;listen.mode = 0660
;listen.allowed_clients = 127.0.0.1
;priority = -19
pm = dynamic
pm.max_children = 5
pm.start_servers = 2
pm.min_spare_servers = 1
pm.max_spare_servers = 3
;pm.process_idle_timeout = 10s;
;pm.max_requests = 500
;pm.status_path = /status
;ping.path = /ping
;ping.response = pong
;access.log = log/$pool.access.log
;access.format = "%R - %u %t \"%m %r%Q%q\" %s %f %{mili}d %{kilo}M %C%%"
;slowlog = log/$pool.log.slow
;request_slowlog_timeout = 0
;request_terminate_timeout = 0
;rlimit_files = 1024
;rlimit_core = 0
;chroot =
chdir = /
;catch_workers_output = yes
;security.limit_extensions = .php .php3 .php4 .php5
;env[HOSTNAME] = $HOSTNAME
;env[PATH] = /usr/local/bin:/usr/bin:/bin
;env[TMP] = /tmp
;env[TMPDIR] = /tmp
;env[TEMP] = /tmp

env [DB_HOST] = localhost
env [DB_PORT] = 3306
env [DB_FORUM] = forum
env [DB_USER] = root
env [DB_PASS] = ...


;php_admin_value[sendmail_path] = /usr/sbin/sendmail -t -i -f www@my.domain.com
;php_flag[display_errors] = off
;php_admin_value[error_log] = /var/log/fpm-php.www.log
;php_admin_flag[log_errors] = on
;php_admin_value[memory_limit] = 32M

```


### Разные версии php из-под разных пользователей для разных хостов

* Создаем pool в php-FPM
* `sudo service php5.6-fpm restart`



### Передача переменных окружения через сокет (пул)

`nano /etc/php5.6/fpm/pool.d/username.conf`

```
env[FORUM_DB_HOST] = localhost
env[FORUM_DB_PORT] = 
env[FORUM_DB_NAME] = ...
env[FORUM_DB_USER] = ...
env[FORUM_DB_PASS] = ...
```


## Редиректы

```
server {
	...
	index ...
	...
  if ($request_uri ~* "^/index\.php(.*?)$") {
    return 301 /$1;
  }
  location / {
  	try_files $uri $uri/ =404;
  }
}
```


## php-fpm

iadfeshchm@iadfeshchm-pc ~ $ sudo apt-get install php5-cli php5-common php5-mysql php5-gd php5-fpm php5-cgi php5-fpm php-pear php5-mcrypt
Чтение списков пакетов… Готово
Построение дерева зависимостей       
Чтение информации о состоянии… Готово
php5-cli is already the newest version.
php5-common is already the newest version.
php5-common установлен вручную.
php5-gd is already the newest version.
Будут установлены следующие дополнительные пакеты:
  libmcrypt4
Предлагаемые пакеты:
  libmcrypt-dev mcrypt php5-dev
Пакеты, которые будут УДАЛЕНЫ:
  php5-mysqlnd
НОВЫЕ пакеты, которые будут установлены:
  libmcrypt4 php-pear php5-cgi php5-fpm php5-mcrypt php5-mysql
обновлено 0, установлено 6 новых пакетов, для удаления отмечено 1 пакетов, и 0 пакетов не обновлено.
Необходимо скачать 6 885 kБ архивов.
После данной операции, объём занятого дискового пространства возрастёт на 29,8 MB.
