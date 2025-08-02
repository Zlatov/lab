# CSS Grid

`display: grid` — система для раскладки элементов в двумерной сетке: по строкам и колонкам.


## Пример

```css
.container {
  display: grid;
  grid-template-columns: 100px 1fr 2fr;
  grid-template-rows: auto auto;
  gap: 10px; /* между всеми строками и колонками */
}
```

```html
<div class="container">
  <div>1</div>
  <div>2</div>
  <div>3</div>
  <div>4</div>
</div>
```

## Основные свойства контейнера

### Размер колонок и строк

```css
grid-template-columns: 100px 1fr 2fr;
grid-template-rows: auto 200px;
```

* `px`, `em`, `%` — обычные единицы.
* `fr` — доля свободного пространства.

### Автоматическая генерация

```css
grid-template-columns: repeat(3, 1fr);
```

То же самое что:

```css
grid-template-columns: 1fr 1fr 1fr;
```

---

### 🔄 Автозаполнение

```css
grid-template-columns: repeat(auto-fill, minmax(150px, 1fr));
```

* Автоматически создаёт столько колонок, сколько влезает.
* `minmax()` — укажи минимальный и максимальный размер.

---

## Расстояния между ячейками

```css
gap: 20px; /* или: row-gap / column-gap */
```

---

## Выравнивание внутри сетки

```css
justify-items: start | center | end;  /* по горизонтали */
align-items: start | center | end;    /* по вертикали */
```

Выравнивает **внутри** каждой ячейки.

---

## Выравнивание всей сетки

```css
justify-content: start | center | space-between;
align-content: center;
```

Выравнивает **всю сетку** в контейнере.


## Расположение элементов

### Ручное позиционирование

```css
.item {
  grid-column: 1 / 3; /* с 1 по 2 включительно */
  grid-row: 2 / 4;
}
```

### Однострочно:

```css
grid-column: span 2;  /* занять 2 колонки */
```


## Автоматическая раскладка

```css
grid-auto-rows: 100px;       /* высота автоматически созданных строк */
grid-auto-columns: 200px;    /* ширина для колонок, если не указано */
```


## Объединение нескольких ячеек

```css
.item {
  grid-column: 1 / 3;
  grid-row: 1 / 3;
}
```


## Частые примеры

### Равномерная сетка из 3 колонок

```css
.container {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 1rem;
}
```


### Адаптивная сетка

```css
.container {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
  gap: 1rem;
}
```

Растягивается/сжимается, отлично для карточек.


## Коротко

| Свойство                     | Что делает                       |
| ---------------------------- | -------------------------------- |
| `display: grid`              | Включает грид                    |
| `grid-template-columns`      | Настраивает колонки              |
| `grid-template-rows`         | Настраивает строки               |
| `gap`                        | Отступы между ячейками           |
| `grid-column` / `row`        | Указывает, где элемент находится |
| `justify-*`, `align-*`       | Центровка по осям                |
| `fr`, `repeat()`, `minmax()` | Умные единицы измерения          |

