# NPM

Npm — это пакетный менеджер языка javascript исполняемый ядром Node.js.

Nvm — это bash сценарий управления версиями Node.js. Для установки nvm
используйте репозиторий https://github.com/nvm-sh/nvm

## Установка

```bash
# Через системную команду (ubuntu)
sudo apt install -y npm

# Через nvm
# Установку nvm смотреть тут: https://github.com/nvm-sh/nvm
# Чтобы проверить, что nvm был установлен, выполните:
command -v nvm
# Список версий для установки
nvm list-remote
# Установка необходимой версии
nvm install v12.17.0
# Список установленных версий
nvm list
# Переключиться на версию
nvm use v12.17.0
# Установить версию по умолчанию
nvm alias default v12.17.0
# Проверить версию
node --version
```

## Обновление node.js до последней версии

```
node -v
nodejs -v
npm -v
which node
which nodejs

sudo npm cache clean -f
sudo npm install npm@latest -g
sudo npm install -g n
sudo n stable
```

## Настройки

* `npm config list`
* `npm config ls -l`
* `npm config edit`

### Кастомизация пути вендора при установки отдельного пакета

`npm install archy --prefix ./theme/yarn`

### Прокси

`subl ~/.npmrc` `proxy=http://proxy.domain:3111/`

## Использование

* `npm install <package-name>`
* `npm install -g less`
* `npm install -g less-plugin-clean-css`

* `--save` — позволяет установить пакет и добавить запись о нём в раздел `dependencies` файла _package.json_.
* `--save-dev` — позволяет установить пакет и добавить запись о нём в раздел `devDependencies` файла `package.json`. Данный раздел содержит перечень зависимостей для разработки, тестирования и т.п.
* `npm update` — для обновления пакетов
