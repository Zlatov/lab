# Mailcatcher

```sh
cd ~
ruby -v # 2.7+
gem install mailcatcher -v 0.8.2
mailcatcher
# или настроить systemd
```

```sh
# touch /etc/systemd/system/mailcatcher.service
# mcedit /etc/systemd/system/mailcatcher.service
[Unit]
Description=mailcatcher
Requires=network.target

[Service]
Type=simple
User=iadfeshchm
Group=iadfeshchm
WorkingDirectory=/home/iadfeshchm

ExecStart=/home/iadfeshchm/.rbenv/shims/mailcatcher --smtp-ip 0.0.0.0

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

# systemctl disable mailcatcher.service
```

```sh
# nginx
server {
    listen 80;
    server_name mailcatcher.local;

    # auth_basic "Restricted Area";
    # auth_basic_user_file /etc/nginx/.htpasswd;

    location / {
        proxy_pass http://127.0.0.1:1080;
        port_in_redirect off;
        proxy_redirect off;
        proxy_buffering off;
    }
}

```
