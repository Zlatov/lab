# Документация синтаксиса markdown

## <a id="toc"></a>Оглавление<a name="anchors-in-markdown"></a><a name="id1"></a>

1. [Заголовки](#z)
    1. Заголовок `h1`
    1. Заголовок `h2`
    1. Заголовки 3 – 6-го уровня
1. Параграфы
1. Списки
    1. Ненумерованные
    1. Нумерованные
1. [Links](#links)
1. [Ссылки](#Ссылки)
1. Коды

## <a id="z"></a>Заголовки [↑](#toc)

### Заголовок `h1`

```
Документация синтаксиса markdown
===
```

или

```
# Документация синтаксиса markdown
```

### Заголовок `h2`

```
Заголовки
---
```

или

```
## Заголовки
```

### Заголовки 3 – 6-го уровня

```
### З. 3
#### З. 4
##### З .5
###### З .6
```

## Списки

### Ненумерованные

* foo
* bar
* baz
* qux
* quux
* quuux

asd

- foo
- bar
- baz
- qux
- quux
- quuux

asd

+ foo
+ bar
+ baz
+ qux
+ quux
+ quuux

asd

* foo
    * bar
        * baz
    * qux
* quux
* quuux

### Нумерованные

1. Заголовки
    1. Заголовок `h2`
        1. Заголовки 3 – 6-го уровня
1. Параграфы
1. Списки
1. Ссылки
1. Коды

## Links

asd

## Ссылки

[create an anchor](#anchors-in-markdown)

[Абсолютная ссылка](https://www.google.com)

[Абсолютная ссылка с тайтлом](https://www.google.com "Домашняя страница Гугла")

[Относительная ссылка на идентификатор в текущем документе заданный немедленно](#id1)

[Относительная ссылка на идентификатор в текущем документе заданный немедленно](#Оглавление)

[Относительная ссылка на идентификатор в текущем документе заданный сноской (на гитхаб не работает)][id2]
[id2]: #id2

[I'm a relative reference to a repository file](../blob/master/LICENSE)

[You can use numbers for reference-style link definitions][1]

Or leave it empty and use the [link text itself].

URLs and URLs in angle brackets will automatically get turned into links. 
http://www.example.com or <http://www.example.com> and sometimes 
example.com (but not on Github, for example).

Some text to show that the reference links can follow later.

[1]: http://slashdot.org
[link text itself]: http://www.reddit.com

## Коды<a name="codes"></a>
[codes]: #codes


`cd ..`

```javascript
var s = "JavaScript syntax highlighting";
alert(s);
```

## Зарезервированные символы {#asdasd}

* \\   (`\`)  — обратная косая черта
* \`   (\`)   — обратный апостроф
* \*   (`*`)  — звёздочка
* \_   (`_`)  — символ подчёркивания
* \{\} (`{}`) — фигурные скобки
* \[\] (`[]`) — квадратные скобки
* \(\) (`()`) — круглые скобки
* \#   (`#`)  — решётка
* \+   (`+`)  — плюс
* \-   (`-`)  — минус (дефис)
* \.   (`.`)  — точка
* \!   (`!`)  — восклицательный знак
