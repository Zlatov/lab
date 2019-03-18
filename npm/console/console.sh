#!/usr/bin/env bash

set -eu

exit 0

# 
# Настройки
# 
npm config list
npm config ls -l
npm config edit

# 
# Список установленных пакетов
# 
npm list -g --depth 0
# `list -g` - отображать дерево каждого пакета, найденного в папках пользователя (безопции -g отображаются только пакеты текущего каталога)
# `--depth 0` - избегать включения зависимостей каждого пакета в древовидное представление


# 
# Список доступных версий пакета
# 
npm view semantic-ui versions --json

# 
# Установка
# 
npm install <package-name>
npm install semantic-ui
npm install semantic-ui@2.2.13
# --save — позволяет установить пакет и добавить запись о нём в раздел dependencies файла package.json.
# --save-dev — позволяет установить пакет и добавить запись о нём в раздел devDependencies файла package.json. Данный раздел содержит перечень зависимостей для разработки, тестирования и т.п.
# npm update — для обновления пакетов
