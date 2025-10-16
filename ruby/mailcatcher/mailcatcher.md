# Mailcatcher

```bash
# Проверяем, есть процессы слушающие необходимые нам порты.
ss -tlnp | grep ':1025\>'
ss -tlnp | grep ':1080\>'
docker run -d -p 1025:1025 -p 1080:1080 --name mailcatcher schickling/mailcatcher
# http://localhost:1080/
# SMTP_PORT=1025

docker stop mailcatcher
docker rm mailcatcher
docker run -d            --network host --name mailcatcher schickling/mailcatcher
```

```sh
cd ~
# На руби 3 константа Fixnum не определена, и mailcatcher не работает.
rbenv install 2.7.8
mkdir -p projects/my/mailcatcher
cd projects/my/mailcatcher
rbenv local 2.7.8
gem install -N mailcatcher -v 0.8.2
# -N - без документации
mailcatcher
# или настроить systemd
```

```sh
# sudo su
# touch /etc/systemd/system/mailcatcher.service
# mcedit /etc/systemd/system/mailcatcher.service
[Unit]
Description=mailcatcher
Requires=network.target

[Service]
Type=simple
User=iadfeshchm
Group=iadfeshchm
WorkingDirectory=/home/iadfeshchm/projects/my/mailcatcher

ExecStart=/home/iadfeshchm/.rbenv/bin/rbenv exec mailcatcher --smtp-ip 0.0.0.0

Restart=on-failure

TimeoutStartSec=10
WatchdogSec=30

KillMode=process

[Install]
WantedBy=multi-user.target

# systemctl enable mailcatcher.service
# systemctl daemon-reload
# systemctl start mailcatcher
# systemctl status mailcatcher
# journalctl -u mailcatcher
# http://localhost:1080

# systemctl disable mailcatcher.service
```

```sh
# sudo touch /etc/nginx/sites-available/mailcatcher.local.conf
# sudo subl /etc/nginx/sites-available/mailcatcher.local.conf
server {
    listen 127.0.0.1:80;
    server_name mailcatcher.local;
    client_max_body_size 256m;

    location / {
        proxy_pass http://127.0.0.1:1080;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;

        proxy_connect_timeout 600;
        proxy_read_timeout 600;

        port_in_redirect off;
        proxy_redirect off;
        proxy_buffering off;
    }
}

# sudo ln -s /etc/nginx/sites-available/mailcatcher.local.conf /etc/nginx/sites-enabled/mailcatcher.local.conf
# sudo nginx -t
# sudo nginx -s reload
# sudo systemctl restart nginx
# echo "127.0.0.1  mailcatcher.local" | sudo tee -a /etc/hosts
```
