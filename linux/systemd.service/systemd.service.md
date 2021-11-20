Настройка процесса используемого в качестве сервиса производится в файлах
_/etc/systemd/system/*.service_, например:

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
Description=<service_name>
Requires=network.target
After=network.target

[Service]
# simple - демонизировать простой процесс
# forking - процесс разветвляется с завершением родительского процесса
# (позволяет демонизировать).
Type=forking
# Оставлять пид процесса при остановке приложения (не сервиса).
RemainAfterExit=yes
# Где лежит пид
PIDFile=<working_directory>/tmp/pids/server.pid

User=deployer
Group=deployer

WorkingDirectory=<working_directory>
EnvironmentFile=<working_directory>/variables.env

ExecStart=/home/iadfeshchm/.rbenv/bin/rbenv exec bundle exec puma -C /home/iadfeshchm/projects/zenon/zenonline/config/puma.rb --daemon
ExecStop=/home/iadfeshchm/.rbenv/bin/rbenv exec bundle exec pumactl -F /home/iadfeshchm/projects/zenon/zenonline/config/puma.rb stop
ExecReload=/home/iadfeshchm/.rbenv/bin/rbenv exec bundle exec pumactl -F /home/iadfeshchm/projects/zenon/zenonline/config/puma.rb restart

# Значительно уменьшить фрагментацию памяти Ruby = Снижение многопоточности
# https://www.mikeperham.com/2018/04/25/taming-rails-memory-bloat/
Environment=MALLOC_ARENA_MAX=2

# По истечении какого времени считать запуск проваленным.
TimeoutStartSec=20
# По истечении какого времени считать остановку проваленой и запускать SIGTERM
# остановку процесса.
TimeoutStopSec=10
# Синоним для задания одновременно TimeoutStartSec и TimeoutStopSec.
# TimeoutSec=5

# Настраивает тайм-аут сторожевого таймера для службы. Сторожевой таймер
# активируется после завершения запуска.
WatchdogSec=10

# Время ожидания перед перезапуском службы. Принимает значение без единиц
# измерения в секундах или значение промежутка времени, например, «5min 20s». По
# умолчанию 100ms.
RestartSec=10s

# Когда производить автоматический перезапуск.
# no|always|on-success|on-failure|on-abnormal|on-abort|on-watchdog
Restart=on-failure

# Уничтожается только основной процесс при убийстве сервиса
# control-group|process|mixed|none
KillMode=process

[Install]
WantedBy=multi-user.target
```

`sudo systemctl enable <service_name>` — добавить в сервисы.
`sudo systemctl daemon-reload` — применить изменения конфигурационных файлов _/etc/systemd/system/*.service_.
