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

```sh
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

## nvm и не-интерактивные окружения (cron, systemd, GUI-хоткеи)

nvm добавляет `node`/`npm`/глобальные бинарники в `PATH` только через
`.bashrc`/`.zshrc` — это работает исключительно в интерактивном шелле.
Команда, запущенная не через него (хоткей GNOME, cron, systemd unit),
этот `PATH` не видит и не находит ни `node`, ни глобально
установленные пакеты, даже если `nvm alias default` настроен.
Стабильного, не завязанного на версию пути у nvm нет в принципе.

Фикс — символическая ссылка в `/usr/local/bin` (он обычно есть в
`PATH` любого процесса в системе, а не только интерактивного шелла):

```bash
sudo ln -sf "$(nvm which current)" /usr/local/bin/node
sudo ln -sf "$(npm root -g)/<пакет>/bin/<entry>.js" /usr/local/bin/<команда>
```

Пример (пакет `debash`):

```bash
sudo ln -sf "$(nvm which current)" /usr/local/bin/node
sudo ln -sf "$(npm root -g)/debash/bin/debash.js" /usr/local/bin/debash
```

⚠️ **Ссылка на `node` жёстко привязана к версии**, активной в момент
выполнения команды (`nvm which current`). При переключении версии
через nvm сама не обновится — придётся пересоздать ссылку заново.


## Настройки

* `npm config list`
* `npm config ls -l`
* `npm config edit`

### Кастомизация пути вендора при установки отдельного пакета

`npm install archy --prefix ./theme/yarn`

### Прокси

`subl ~/.npmrc` `proxy=http://proxy.domain:3111/`

## Использование

```sh
npm install <package-name>
npm install -g less
npm install -g less-plugin-clean-css
npm outdated # какие модули имеют более новые версии
npm update # обновление всех модулей
npm update {package-name} # обновление модуля
```

* `--save` — позволяет установить пакет и добавить запись о нём в раздел `dependencies` файла _package.json_.
* `--save-dev` — позволяет установить пакет и добавить запись о нём в раздел `devDependencies` файла `package.json`. Данный раздел содержит перечень зависимостей для разработки, тестирования и т.п.
* `npm update` — для обновления пакетов
