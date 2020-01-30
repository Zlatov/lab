# 
# Пользователи и группы
# 

# Список пользователей
cut -d: -f1 /etc/passwd
cut -d: -f1,3 /etc/passwd

# Создание пользователя
useradd -d /home/vasyapupkin -s /bin/false -g nogroup vasyapupkin
# -d домашний каталог
# -s не даст юзеру зайти под shell
# -g группа
# -r Создать системную учётную запись (без дом каталога, без устаревания пароля...) sudo useradd -r -s /bin/false fpm

# Более «дружественный» вариант adduser
adduser [-home <домашняя_директория>] [-shell <ОБОЛОЧКА>] [-ingroup <ГРУППА>] <имя_пользователя>
adduser -home /home/deployer -shell /bin/bash deployer

# Удалить пользователя
userdel <имяпользователя>

# Удалить группу
groupdel <имягруппы>

# Задать пароль пользователю
passwd <имяпользователя>

# Добавиьт пользователя в группу
usermod -a -G group user

# Судорес
adduser deployer sudo
# или лучше
usermod -a -G sudo deployer # Ubuntu
usermod -aG wheel username # Centos

# Списко групп пользователя
id -Gn iadfeshchm
# или
groups iadfeshchm
# Основная группа пользователя
getent group iadfeshchm

# Добавиьт пользователю домашнюю директорию
sudo mkdir /home/fpm
sudo chown fpm:fpm /home/fpm

# Разрешить пользователю использовать консоль
sudo usermod -s /bin/bash fpm
