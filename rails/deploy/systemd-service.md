# Деплой рельсы как сервиса в качестве системного демона

Настройка процесса используемого в качестве сервиса производится в файлах _/etc/systemd/system/*.service_, например:

```bash
[Unit]
Description=Puma Zlatov
Requires=network.target

[Service]
Type=simple
User=deployer
Group=deployer
WorkingDirectory=/home/deployer/app/zlatov/current
EnvironmentFile=/home/deployer/app/zlatov/current/env.sh

#ExecStop=/home/myapp51/.rbenv/bin/rbenv exec bundle exec pumactl -F /home/myapp51/app/current/config/puma.rb stop
#ExecReload=/home/myapp51/.rbenv/bin/rbenv exec bundle exec pumactl -F /home/myapp51/app/current/config/puma.rb phased-restart

ExecStart=/bin/bash -lc 'bundle exec puma -C /home/deployer/app/zlatov/current/config/puma.rb'
ExecStop=/bin/bash -lc 'bundle exec pumactl -F /home/deployer/app/zlatov/current/config/puma.rb stop'
ExecReload=/bin/bash -lc 'bundle exec pumactl -F /home/deployer/app/zlatov/current/config/puma.rb phased-restart'

TimeoutSec=5
RestartSec=10s
Restart=always

[Install]
WantedBy=multi-user.target
```

```bash
[Unit]
Description=zenonline
#Requires=network.target
After=network.target

[Service]
Type=simple
User=iadfeshchm
Group=iadfeshchm
WorkingDirectory=/home/iadfeshchm/projects/zenon/zenonline
EnvironmentFile=/home/iadfeshchm/projects/zenon/zenonline/variables.env

ExecStart=/home/iadfeshchm/.rbenv/bin/rbenv exec bundle exec puma -C /home/iadfeshchm/projects/zenon/zenonline/config/puma.rb
ExecStop=/home/iadfeshchm/.rbenv/bin/rbenv exec bundle exec pumactl -F /home/iadfeshchm/projects/zenon/zenonline/config/puma.rb stop
ExecReload=/home/iadfeshchm/.rbenv/bin/rbenv exec bundle exec pumactl -F /home/iadfeshchm/projects/zenon/zenonline/config/puma.rb phased-restart

TimeoutSec=5
RestartSec=10s
Restart=always
KillMode=process

[Install]
WantedBy=multi-user.target
```


`sudo systemctl daemon-reload` — применить изменения конфигурационных файлов _/etc/systemd/system/*.service_
