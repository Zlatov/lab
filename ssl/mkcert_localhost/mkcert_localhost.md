# Самоподписанный ssl сертификат на localhost

С помощью утилиты mkcert можно создать сертификат с локальным доверием без ошибок доверия. Mkcert создаёт локальный центр сертификации.

__Установка mkcert__

```bash
sudo apt install libnss3-tools
wget https://github.com/FiloSottile/mkcert/releases/download/v1.1.2/mkcert-v1.1.2-linux-amd64
mv mkcert-v1.1.2-linux-amd64 mkcert
chmod +x mkcert
sudo cp mkcert /usr/local/bin/
```

__Создание локального Центра Сертификации__

```bash
mkcert -install
```

__Создание локально доверенных сертификатов__

```bash
mkcert myapp.local
sudo cp myapp.local.pem /etc/ssl/certs/
sudo cp myapp.local-key.pem /etc/ssl/private/
```

__Настройка nginx с использованием ssl сертификата__

```bash
listen 127.0.0.1:443 ssl;
ssl_certificate /etc/ssl/certs/myapp.local.pem;
ssl_certificate_key /etc/ssl/private/myapp.local-key.pem;
…
# proxy_set_header X-Forwarded-Proto $scheme;
proxy_set_header X-Forwarded-Proto $proxy_x_forwarded_proto;
```
