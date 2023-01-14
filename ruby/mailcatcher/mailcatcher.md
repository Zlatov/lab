# Mailcatcher

```sh
cd ~
ruby -v # 2.7+
gem install mailcatcher -v 0.8.2
mailcatcher
```

<!-- ```sh
# /etc/systemd/system/mailcatcher.local.service
[Unit]
Description=mailcatcher.local
Requires=network.target

[Service]
Type=simple
User=iadfeshchm
Group=iadfeshchm
WorkingDirectory=/home/iadfeshchm

ExecStart=mailcatcher

Restart=on-failure

TimeoutStartSec=10
WatchdogSec=30

KillMode=process

[Install]
WantedBy=multi-user.target

# sudo systemctl enable store.local.service
# sudo systemctl disable store.local.service
# sudo systemctl daemon-reload
```
 -->