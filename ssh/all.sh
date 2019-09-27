#!/usr/bin/env bash
set -eu
exit 0

# Сгенерировать пару ключей
ssh-keygen -t rsa

# Список ключей
ls -lah ~/.ssh

# Копируем публичную часть на сервер
ssh-copy-id -i ~/.ssh/id_rsa.pub myserv

# Принудительно запрашивать пароль
ssh -o PreferredAuthentications=password -o PubkeyAuthentication=no user@host

# Принудительно запрашивать пароль
sudo apt install -y openssh-server
sudo service ssh status
