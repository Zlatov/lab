#!/usr/bin/env bash
exit 0

# Установить composer
cd ~
curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer
composer global require "fxp/composer-asset-plugin:~1.1.1"

# Обновить версию composer
composer self-update
sudo composer self-update

# Использование
composer validate             # - проверить composer.json
composer show zlatov/sql      # - информация об установленном пакете
composer require zlatov/tree  # - подключить пакет

composer search zlatov
composer install zlatov/tree
composer update
composer update --lock        # - после того, как вручную отредактирован composer.json,
                              # даже если изменения незначимы, composer обнаружит, что
                              # md5sum файла изменена.
                              # ```
                              # Warning: The lock file is not up to date with the
                              # latest changes in composer.json
                              # ```
                              # Чтобы подавить предупреждение, запустите команду для
                              # обновления lock-файла без обновления самих пакетов.

composer remove zlatov/tree zlatov/sql

composer show                 # - список всех установленных пакетов.
composer show --all           # - список всех доступных пакетов.
composer show zlatov/sql [v]  # - инфо об указанном пакете или его специфичной версии.

# Новый пакет
git init
composer init
