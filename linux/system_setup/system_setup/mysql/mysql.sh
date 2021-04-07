#!/usr/bin/env bash
set -eu

cd ~
lab_path=projects/my/lab
. $lab_path/bash/_lib/echoc

# 
# Удаление
# 

# echoc "Удаление…" yellow
# sudo apt-get -y remove --purge mysql-server mysql-client mysql-common
# sudo apt-get -y autoremove
# sudo apt-get -y autoclean
# sudo rm -rf /etc/mysql и sudo rm -rf /var/lib/mysql
# echoc "Удалено." green

# 
# Обновление списка пакетов в соответствии с доверенными репозиториями
# 

[[ -z ${SYSTEM_SETUP_APT_UPDATE-} ]] && sudo apt-get -qq update

# 
# Установка
# 

if hash mysql 2>/dev/null
then
  echoc "Уже установлен mysql." blue
else
  echoc "Установка mysql." yellow
  sudo apt-get install mysql-server -y 1>/dev/null
  echoc "Установлен mysql." green
fi

# 
# Настройка пароля
# 

echoc "Настройка доступов…" yellow
sudo mysql_secure_installation
echoc "Настроены доступы." green

# 
# Настройка не-sudo пароля (fix)
#

echoc "Настройка не-sudo доступа к mysql -uroot…" yellow
echoc -n "Введите новый пароль:" yellow
echo -n " "
read -s SYSTEM_SETUP_MYSQL_PASSWORD
echo
echoc "Mysql запросит текущий пароль:" yellow
sudo mysql -uroot -p <<- SQL
  FLUSH PRIVILEGES;
  UPDATE mysql.user SET plugin = 'mysql_native_password' WHERE user = 'root';
  FLUSH PRIVILEGES;
  -- SET GLOBAL validate_password_special_char_count = 0;
  -- FLUSH PRIVILEGES;
  -- GRANT ALL ON *.* TO 'root'@'localhost' IDENTIFIED BY '${SYSTEM_SETUP_MYSQL_PASSWORD}' WITH GRANT OPTION;
  ALTER USER 'root'@'localhost' IDENTIFIED BY '${SYSTEM_SETUP_MYSQL_PASSWORD}';
  FLUSH PRIVILEGES;
  exit
SQL
sudo service mysql restart
echoc "Настроен не-sudo доступ к mysql -uroot." green
