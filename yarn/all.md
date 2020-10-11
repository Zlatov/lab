# Yarn

Yarn — это менеджер пакетов для вашего кода.


## Установка

```bash
# deb
sudo apt-get update && sudo apt-get install yarn
```


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
* `yarn add [package]@[tag]`;
* пример: `yarn add jquery@^2`.

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

`yarn install --network-timeout 1000000` - при испытывании проблем с установкой соединения.

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

## Публикация пакета

При указании новой версии в процессе публикации с помощью `yarn publish` yarn создаёт тэг „vX.X.X“ вместо „X.X.X“, поэтому лучше:

1.   Вручную изменить версию пакета в _package.json_;
2.   Добавить тэг с новой версией в гит и запушить новый тэг;
3.   При `yarn publish` не указывать увеличение версии, а жать просто <kbd>Enter</kbd>.

### Авторизация при публикации пакета на npm.pkg.github.com

(полная херня, не понимаю пока зачем это, команда по установке пакета с самого
сайта npm.pkg.github.com тупо не работает - говорит нет пакета, хотя вот он и
вот его команды бери копируй... бред. Грохаем настройку с npm.pkg.github.com и
всё работает как прежде)

1.   Создать токен на GitHub в разделе __Settings -> Developer settings ->
     Personal access tokens__, выдав права __read:packages, write:packages__;
2.   `npm login --registry https://npm.pkg.github.com` введя вместо пароля токен GitHub;
3.   `yarn publish`
