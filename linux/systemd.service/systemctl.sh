exit 0

sudo service nginx stop
sudo service nginx start
sudo service nginx restart
sudo service nginx status

sudo systemctl disable nginx
sudo systemctl enable custom_service

# Применить изменения конфигурационных файлов _/etc/systemd/system/*.service_
systemctl daemon-reload

# 
# Добавление сервиса в systemctl
# 
# файл /etc/systemd/system/elasticsearch.service:
# 
# ```
# [Unit]
# Description=elas demo service
# After=network.target
# StartLimitIntervalSec=0
# [Service]
# Type=simple
# Restart=always
# RestartSec=1
# User=iadfeshchm
# ExecStart=/usr/bin/env php /path/to/server.php
# [Install]
# WantedBy=multi-user.target
# ```
# 
# systemctl start elasticsearch
# 

# Список сервисов
systemctl
systemctl | grep httpd # Список запущенных сервисов.
systemctl list-units --type service
systemctl list-units --type mount


# Лог сервиса по имени
journalctl -u nginx.service
