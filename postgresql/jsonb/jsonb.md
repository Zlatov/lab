# JSONB

## Операторы для типов json и jsonb

* `JSON::json -> INT` - возвращает элемент массива JSON с ключём INT.
* `JSON::json -> STR` - возвращает элемент объекта JSON с полем STR.
* `JSON::json ->> INT` - возвращает элемент массива JSON в типе _text_.
* `JSON::json ->> STR` - возвращает элемент объекта JSON в типе _text_.
* `JSON::json #> PATH` - возвращает объект в JSON по заданному пути PATH (`{a,b}`|`{asd,2}`).
* `JSON::json #>> PATH` - возвращает объект в JSON по заданному пути PATH в типе _text_.

__Дополнительные операторы jsonb__

* `JSONB::jsonb @> JSONB::jsonb` - левый объект содержит все пары ключ-значение правого объекта?
* `JSONB::jsonb <@ JSONB::jsonb` - все пары ключ-значение левовго объекта содержатся в правом объекте?
* `JSONB::jsonb ? STR` - строка STR это ключ объекта JSON?
* `JSONB::jsonb ?| ARR` - какие-либо строки массива ARR (`array['a', 'b']`) присутствуют в качестве ключей объекта JSON?
* `JSONB::jsonb ?& ARR` - все строки массива ARR присутствуют в качестве ключей объекта JSON?
* `JSONB::jsonb || JSONB::jsonb` - объединение двух объектов.
* `JSONB::jsonb - STR` - удаляет поле объекта.
* `JSONB::jsonb - INT` - удаляет запись массива.
* `JSONB::jsonb #- PATH` - удаляет поле изи запись по пути PATH.

## Приведение к типам

Типы https://www.postgresql.org/docs/current/datatype.html

```sql
SELECT field::text
SELECT field::int
SELECT field::float
```
