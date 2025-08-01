## Что теперь даёт `rails new`

По умолчанию `rails new` **не ставит никакой frontend-сборщик**, если не указан
флаг `--javascript` или `--css`. То есть: **нет Webpacker**, **нет
Importmap**, **нет esbuild**, **ничего лишнего**.

"пустой" проект, что идеально для дальнейшего ручного управления.

### `bundle add jsbundling-rails`

* Подключает гем [`jsbundling-rails`](https://github.com/rails/jsbundling-rails)
* Этот гем **не собирает JS сам**, а **оборачивает внешний JS-сборщик**, например:

  * `esbuild` — по умолчанию (самый лёгкий)
  * `rollup`
  * `webpack`

Выбираем сборщик позже командой:

```bash
bin/rails javascript:install:esbuild
```

Эта команда:

* Устанавливает `esbuild` через `npm`
* Создаёт `app/javascript/application.js`
* Настраивает `package.json` и `build`-скрипты
* Прописывает `application.js` в layout через `javascript_include_tag`

---

### `bundle add cssbundling-rails`

* Подключает гем [`cssbundling-rails`](https://github.com/rails/cssbundling-rails)
* Аналогично: **оборачивает внешний CSS-процессор**
* Сами выбираем какой:

```bash
bin/rails css:install:sass
```

Это:

* Устанавливает `sass` через `npm`
* Создаёт `app/assets/stylesheets/application.sass`
* Прописывает его в layout

---

### `Turbo`

* Turbo входит в состав [`hotwired`](https://hotwired.dev/)
* Он уже **включён в Rails** (начиная с 7.0)
* Но по умолчанию не активирован, пока явно не подключаем его в `application.js`:

```js
import "@hotwired/turbo-rails"
```

---

### `Propshaft`

* Это **новая альтернатива Sprockets** от Rails
* Rails 8 по умолчанию использует `propshaft` вместо `sprockets-rails`
* Отвечает за asset pipeline (например, картинки, шрифты, favicon)
* Работает без манифестов, без `require`, на чистых путях и ссылках

Всё по-прежнему через:

```bash
rails assets:precompile
```

Просто `Propshaft` использует **другую реализацию** этой команды. И она **намного быстрее и проще**, чем у Sprockets.

---

### Резюме: что за что отвечает

| Компонент           | Назначение                               | Команда подключения                                                |
| ------------------- | ---------------------------------------- | ------------------------------------------------------------------ |
| `jsbundling-rails`  | Управление сборкой JS (через esbuild)    | `bundle add jsbundling-rails` + `rails javascript:install:esbuild` |
| `cssbundling-rails` | Управление SCSS (через sass или postcss) | `bundle add cssbundling-rails` + `rails css:install:sass`          |
| `Turbo` (hotwired)  | Автообновление страниц, SPA-like UX      | Уже встроен, `import "@hotwired/turbo-rails"` в JS                 |
| `Propshaft`         | Новый asset pipeline (без sprockets)     | Включён в Rails 8 по умолчанию                                     |

---

## Путь от Rails new

```bash
rails new . --database=postgresql
bundle add jsbundling-rails cssbundling-rails
bin/rails javascript:install:esbuild
bin/rails css:install:sass
npm install bootstrap jquery @popperjs/core
```

`application.js`:

```js
import "bootstrap"
import "jquery"
import "@hotwired/turbo-rails"
```

`application.sass`:

```scss
$primary: #990000;
@import "bootstrap/scss/bootstrap";
```

Получили rails Без webpack, без реактов, с sass, bootstrap и turbo.
