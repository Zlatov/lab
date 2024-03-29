# Метапрограммирование

## Наименования

### Параметр (params) или аргумент (args)

*Аргумент* — что конкретно было передано функции в момент вызова.

*Параметр* — принятый функцией аргумент (и при объявлении и при вызове).

Важно различать:

1.  *Формальный параметр* — аргумент, указываемый при объявлении.
2.  *Фактический параметр* — аргумент, передаваемый в функцию при её вызове.

**Наименования**

```
parameter, argument
param, arg
params, args
```

### Элемен (element) или Предмет (item)

*   *Element* - составная часть логически связанного объекта, например модели ИС
    (User, Order, Client, Comment...)
*   *Item* - составная часть однородного списка, например комментарии поьзователя
    user.сomments
*   *Entry* (Запись) - составная часть неоднородного списка, каждый элемент
    которого может существовать независимо.

**Наименования**

```
element, item, entry
elements, items, entries
e, i, e
```

### Количество

*   *Amount* — неисчисляемымые существительные, например: "немыслимое количество
    времени";
*   *Quantity* — исчисляемые существительне, обычно неодушевленные, например: "сколько
    запчастей вы купите?";
*   *Number* — исчисляемые существительне, обычно отражает количество, которое
    известно неточно, например: "пострадало много человек.";
*   *Count* — подразумевает подсчет или полученное в его результате число: "их число
    превысило 50 особей."

## Правила для проектирования структуры папок

*   Держите Структуру как можно более плоским (папка с множеством файлов а не
    наоборот).
*   Создавайте папки только при необходимости (если фалов мало, то пусть лежат
    рядом, даже если они разного типа).
*   Создайте осмысленное имя для своей папки (имя папки должно представлять
    Общую функциональность файлов внутри нее).
*   Если Структура не вызывает радости, реструктурируйте как можно раньше.
