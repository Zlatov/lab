# Итак, начнем. Для начала, часто имеет смысл подключить EPEL:
yum install epel-release

# Установка пакетов производится так:
yum install gcc

# Получение информации о пакете:
yum info git

# Получение списка зависимостей пакета:
yum deplist git

# Проверка наличия доступных обновлений:
yum check-update

# Обновление всех установленных пакетов:
yum update

# Обновление конкрутного пакета:
yum update yum

# Откатываем пакет к предыдущей версии:
yum downgrade git

# Переустанавливаем пакет:
yum reinstall git

# Удаление пакета:
yum remove git

# Список всех доступных пакетов:
yum list available | less

# Спискок всех установленных пакетов:
yum list installed | less

# Спискок вообще всех пакетов:
yum list all | less

# Проверить, установлен ли пакет:
yum list mutt
yum list mysql*

# Поиск по пакетам:
yum search mutt

# История установки/обновления/удаления пакетов:
yum history

# Посмотреть детали о записи в истории:
yum history info 42

# Откатить изменение из истории (вы же за это любите NixOS?):
yum history undo 42

# Повторить изменения из истории:
yum history redo 42

# Определение, к какому пакету относится файл:
yum provides /usr/bin/pstree

# А так можно посмотреть все файлы, которые входят в конкретный пакет:
yum install yum-utils
repoquery -l psmisc

# Также в пакет yum-utils входит команда для установки отладочных символов, необходимых, если вы иногда запускаете gdb:
debuginfo-install glibc

# Часто нужной debuginfo нет в обычных репозиториях, но ее можно найти на filewatcher.com. Например, если ищем отладочные символы для:
nspr-4.10.6-1.el6_6.x86_64
# … то вводим в поиске:
nspr-debuginfo-4.10.6-1.el6_6.x86_64

# Список репозиториев:
yum repolist

# Список групп пакетов:
yum grouplist

# Получение информации о группе:
yum groupinfo "Web Server"

# Установка группы пакетов:
yum groupinstall "Web Server"

# Удаление группы пакетов:
yum groupremove "Web Server"

# Установка скаченного RPM-файла:
yum install path/to/some.rpm
# … или:
rmp -i path/to/some.rpm

# Много разных RPM можно найти на сайте rpmfind.net.
