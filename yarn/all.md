# Yarn

Yarn — это менеджер пакетов для вашего кода.

## Настройки

__Кастомизация вендора:__

В файле _.yarnrc_:

```
--modules-folder theme/yarn
```

При отличающемся пути вендора yarn от пути вендора npm при установке некоторых пакетов (_semantic-ui_) могут возникнуть проблемы `Cannot find module '...'` связанные с невозможностью найти необходимые пакеты. Необходимо вручную с помощью пакетного менеджера npm установить эти паки кастомизировав путь вендора с помощью опции `--prefix <path>`, например `npm install archy --prefix ./theme/yarn`.

Хотя в случае с _semantic-ui_ даже это не поможет. Лучше установить его с помощь npm.

__Прокси:__

`yarn config set https-proxy http://proxy.newstar.ru:3128`

`yarn config delete proxy`

## Команды

Старт нового проекта.

* `yarn init`

Добавить зависимости:

* `yarn add [package]`;
* `yarn add [package]@[version]`;
* `yarn add [package]@[tag]`.

Указать категорию зависимостей devDependencies, peerDependencies, и optionalDependencies соответственно:

* `yarn add [package] --dev`;
* `yarn add [package] --peer`;
* `yarn add [package] --optional`.

Обновить зависимости:

* `yarn upgrade [package]`;
* `yarn upgrade [package]@[version]`;
* `yarn upgrade [package]@[tag]`.

`yarn remove [package]` — удалить зависимости.

`yarn` или `yarn install` — установить все зависимости проекта.

## Создание пакета

```
mkdir package-name
cd package-name
git init
yarn init
git remote add origin git@github.com:User_name/package-name.git
git add .
git commit -m "init"
git push -u origin master
yarn add webpack --dev
…
yarn publish
```
