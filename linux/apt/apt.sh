#!/usr/bin/env bash
exit 0

sudo apt-get update # — обновить список доступных пакетов, имеющихся в источниках (репозиториеях), определенных в файле /etc/apt/sources.list и каталоге /etc/apt/sources.list.d. Вы должны регулярно запускать эту команду для обновления списка пакетов.

sudo apt-get upgrade # — обновить все пакеты в системе (без установки дополнительных пакетов или удаления пакетов)
apt-get dist-upgrade # — обновить все установленные в системе пакеты с установкой или удалением дополнительных пакетов, если это потребуется для обновления какого-то пакета. Команда upgrade оставит старую установленную версию пакета, если для разрешения новых зависимостей при обновлении потребуется установка дополнительных пакетов. Команда dist-upgrade менее консервативна.

sudo apt-get install foo

# Удалить пакет из системы
sudo apt-get remove foo
sudo apt-get --purge remove foo # — удалить из системы пакет и все его файлы настроек

# Найти
apt-cache search foo # Найти пакеты, содержащие в своём описании `foo`
apt-cache pkgnames foo # Найти и перечислить все пакеты, имя которых начинается с foo

# Показать
apt-cache show foo # — показать подробную информацию об установленном пакете.
apt-cache policy foo # — показать краткую (статутс: утсановлен/не установлен, доступные версии) информацию о пакете
apt-cache depends foo # — показать зависимости пакета
apt-cache showpkg foo # — показать подробную информацию о доступных версиях пакета и о пакетах, от него зависящих (об обратных зависимостях пакета)
apt list --upgradable # — показать список пакетов доступных для обновления

# Проксирование apt
cd /etc/apt/apt.conf.d && sudo touch proxy.conf && sudo subl proxy.conf
# Acquire::http::Proxy "http://user:password@proxy.server:port/";
# Acquire::https::Proxy "http://user:password@proxy.server:port/";
# Acquire::http::Proxy "http://proxy.server:port/";
# Acquire::https::Proxy "http://proxy.server:port/";
# Перезагрузить ubuntu!
