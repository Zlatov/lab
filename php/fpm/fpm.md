```bash
sudo systemctl status php5.6-fpm
sudo systemctl start php5.6-fpm
sudo systemctl stop php5.6-fpm
sudo systemctl restart php5.6-fpm
```

```bash
sudo apt update
sudo apt install apache2 libapache2-mod-fastcgi
```

```bash
a2enmod actions fastcgi alias proxy_fcgi
```

```
<FilesMatch \.php$>
# 2.4.10+ can proxy to unix socket
SetHandler "proxy:unix:/var/run/php/php7.2-fpm.sock|fcgi://localhost/"

# Else we can just use a tcp socket:
#SetHandler "proxy:fcgi://127.0.0.1:9000"
</FilesMatch>
```
