#!/usr/bin/env bash
exit 0

# Обновить список доступных пакетов, имеющихся в источниках (репозиториеях),
# определенных в файле /etc/apt/sources.list и каталоге /etc/apt/sources.list.d.
# Вы должны регулярно запускать эту команду для обновления списка пакетов.
sudo apt-get update

# Обновить все пакеты в системе (без установки дополнительных пакетов или
# удаления пакетов)
sudo apt-get upgrade
# Обновить все установленные в системе пакеты с установкой или удалением
# дополнительных пакетов, если это потребуется для обновления какого-то пакета.
# Команда upgrade оставит старую установленную версию пакета, если для
# разрешения новых зависимостей при обновлении потребуется установка
# дополнительных пакетов. Команда dist-upgrade менее консервативна.
apt-get dist-upgrade


sudo apt-get install foo


# Удалить пакет из системы
sudo apt-get remove foo
sudo apt-get --purge remove foo # — удалить из системы пакет и все его файлы настроек
sudo apt remove steam
sudo apt clean && sudo apt autoremove
# clean: Удаляет кеш программ, которые старше той, которая была установлена.
# autoremove: удаляет файлы, которые больше не нужны, например зависимости.

# Найти
# Найти пакеты, содержащие в своём описании `foo`
apt-cache search foo
# Найти и перечислить все пакеты, имя которых начинается с foo
apt-cache pkgnames foo


apt-mark hold foo # Пометить как зафексированный (версия).

# Показать
# Показать подробную информацию об установленном пакете.
apt-cache show foo
# Показать краткую (статутс: утсановлен/не установлен, доступные версии) информацию о пакете
apt-cache policy foo
# Показать зависимости пакета
apt-cache depends foo
# Показать подробную информацию о доступных версиях пакета и о пакетах, от него зависящих (об обратных зависимостях пакета)
apt-cache showpkg foo
# Показать список пакетов доступных для обновления
apt list --upgradable

# Проксирование apt
cd /etc/apt/apt.conf.d && sudo touch proxy.conf && sudo subl proxy.conf
# Acquire::http::Proxy "http://user:password@proxy.server:port/";
# Acquire::https::Proxy "http://user:password@proxy.server:port/";
# Acquire::http::Proxy "http://proxy.server:port/";
# Acquire::https::Proxy "http://proxy.server:port/";
# Перезагрузить ubuntu!
