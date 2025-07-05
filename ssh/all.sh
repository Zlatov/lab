#!/usr/bin/env bash
set -eu
exit 0

# Сгенерировать пару ключей
ssh-keygen -t rsa
ssh-keygen -t rsa -b 4096 -C "Ключ для деплоя приложений"
cat ~/.ssh/id_rsa.pub
cat ~/.ssh/id_rsa
ssh-keygen -t rsa -b 4096 -f ~/.ssh/igni_deploy -C "Ключ для деплоя igni_deploy"
cat ~/.ssh/igni_deploy.pub
cat ~/.ssh/igni_deploy

# Список ключей
ls -lah ~/.ssh

# Копируем публичную часть на сервер
ssh-copy-id -i ~/.ssh/id_rsa.pub myserv

# Принудительно запрашивать пароль
ssh -o PreferredAuthentications=password -o PubkeyAuthentication=no user@host

# 
sudo apt install -y openssh-server
sudo service ssh status

# Настройка для поддержки связи с сервером (на стороне клиента)
# /etc/ssh/ssh_config
Host *
ServerAliveInterval 100
# ServerAliveInterval Клиент будет отправлять нулевой пакет на сервер каждые 100
# секунд, чтобы поддерживать соединение.

# Настройка для поддержки связи с клиентом (на стороне сервера)
# /etc/ssh/sshd_config
ClientAliveInterval 60
TCPKeepAlive yes
ClientAliveCountMax 10000
# ClientAliveInterval Сервер будет ждать 60 секунд перед отправкой нулевого
# пакета клиенту, чтобы поддерживать соединение.
# 
# TCPKeepAlive Предназначен для того, чтобы определенные брандмауэры не
# прерывали незанятые соединения.
# 
# ClientAliveCountMax Сервер будет отправлять живые сообщения клиенту, даже если
# он не получил обратно никакого сообщения от клиента.
