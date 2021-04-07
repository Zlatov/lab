# Sublime Text

## Консоль

Открыть консоль Ctrl+\` или View → Show Console

Отображать все команды в консоли:

```python
sublime.log_commands(True)
```

## API

* https://www.sublimetext.com/docs/3/api_reference.html
* https://habrahabr.ru/post/136529/

## Проекты

Очистить список проектов в „Switch Project“: Project → Open Recent → Clear Items

## Сочетания клавиш

Ctrl + P - список файлов проекта (с поиском) и открытие выбранного;
Ctrl + Shift + P - вывести списко снипетов и команд всех плагинов с поиском, а так же сменить подветку синтаксиса текущего файла;
Ctrl + Alt + P - переключиться на другой проект (с поиском);
Ctrl + R - список методов в файле и переход по ним (с поиском)
Ctrl + G - переход к строке по номеру
Alt + - - переход к предыдущему месту редактирования;
Ctrl + Alt + LMB - чтобы свернуть все папки в сайдбаре сублима достаточно кликнуть ЛКМ по корневой папке с зажатым Ctrl и Alt (в Windows только с Alt).
Ctrl + D - выделить текущее слово или если уже выделены символы, то выделить следующий такой же набор символов
Ctrl + Shift + D -
Ctrl + Shift + G - окружить выделенное новым HTML тегом
Ctrl + Shift + A - выделить все в текущем HTML теге
Ctrl + J - добавить следующую строку (с вычетом отступа следующей строки) к текущей через пробел
Ctrl + Shift + Space - всплывающая подсказка с DocBlock если поствить курсор в начало параметров метода (сразу после открывающей круглой скобки)

__Закладки__

Ctrl + F2 — Установить / снять закладку.
F2 — Перейти к следующей закладке.
⇧ + F2 — Перейти к предыдущей закладке.
Ctrl + ⇧ + F2 — Удалить все закладки.

## Плагины

__ANSIescape__

заставить работать плагин для колорирования текста в Build System:

содержимое файла /home/user/.config/sublime-text-3/Packages/User/Ruby-color.sublime-build:
{
    "cmd": ["ruby", "$file"],
    "file_regex": "rb$",
    "target": "ansi_color_build",
    "syntax": "Packages/ANSIescape/ANSI.tmLanguage"
}

Tools -> Build With...

__CSS Extended Completions__

— выпадающие списки существующих стилей (нужно дабавить в кэш CSS файлы или всю папку по ПКМ в «сайдбаре» и наслаждаться);

__CSS Format__

— упаковывает CSS или наоборот в удобочитаемый;

__Emmet__

— обязательный плагин не нуждается в комментариях;

Каждый раз, мать его, каждый раз при обновлении Sublime, Emmet перестает работать. Приходится, чтоб его, каждый раз производить пляску с бубном что-бы эта тварь заработала:

Удалить Emmet
Удалить PyV8
Удалить сжатую папку /home/iadfeshchm/.config/sublime-text-3/Installed Packages/0_package_control_loader.sublime-package
Установить вручную PyV8 https://github.com/emmetio/pyv8-binaries#manual-installation
Установить Emmet

__PyV8__

При ручной установке (https://github.com/emmetio/pyv8-binaries#manual-installation) архив необходимо распаковать по пути ~/.config/sublime-text-3/Packages/PyV8/... И! по пути ~/.config/sublime-text-3/Installed Packages/PyV8/....

Устанавливается "Почти" автоматически при установке Emmet; (необходим для работы плагина)

__StringUtilities__

— HTML сущности в символы, наоборот и другие полезности;


__HTML-CSS-JS Prettify__

часто ругается что nodejs либо не установлен, либо старая версия:

* лезем в настройки пакета, что стоит в
```json
    "node_path":
    {
        "windows": "C:/Program Files/nodejs/node.exe",
        "linux": "/usr/local/bin/node",
        "osx": "/usr/local/bin/node"
    },
```
* из консоли набрать which node и сверить с тем что в настройках.


__SublimeCodeIntel__

— смотреть настройки, лишнее убрать: например HTML - с ним легко справляются другие плагины;

Чтобы зареиндексить SublimeCodeIntel необходимо удалить файлы В папке: `rm -rf ~/.codeintel/db/*`


__Tag__

— закрывать тэг по /, отступы (автоматическая расстановка отступов просто ужасная) использую из-за отличной работы с атрибутами тегов;

https://github.com/titoBouzout/Tag

скачайте или склонируйте содержимое из этого репозитория в папку с названием пакета в дерикторию Packages саблайм

```
cd ~/.config/sublime-text-3/Packages
git clone https://github.com/titoBouzout/Tag.git
```


__View In Browser__

— открыть файл в браузере;

Настройка проекта

```json
{
    "folders":
    [
        {
            "path": "lab"
        }
    ],
    "settings":
    {
        "sublime-view-in-browser":
        {
            "baseUrl": "http://lab.local/",
            "basePath": "/home/iadfeshchm/projects/my/lab/lab/"
        }
    }
}
```

__HexViewer__

Редактирование шестнадцатиричных и бинарных файлов

## Автокомлит Снипеты Завершения (Completions)

В sublime text можно заменить XCompose (ИксСоставление) Completions (завершениями).

Создаем файл `~/.config/sublime-text-3/Packages/User/my-completions.sublime-complations` с примерно таким содержанием:

```json
{
    "completions": [
        {
            "contents": "–",
            "trigger": "utf8-minus"
        },
        {
            "contents": "—",
            "trigger": "utf8-tire"
        },
        {
            "contents": "«»",
            "trigger": "utf8-kavichki-elki"
        },
        {
            "contents": "„“",
            "trigger": "utf8-kavichki-lapki"
        },
        {
            "contents": "&#8222;&#8220;",
            "trigger": "utf8-kavichki-lapki-html-code"
        },
        {
            "contents": "←↑→↓",
            "trigger": "utf8-strelki"
        },
        "iadfeshchm"
    ]
}
```
