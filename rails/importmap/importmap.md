# Importmap

С выходом Chrome 89 (а так же в Deno 1.8) появилась возможность использовать
Карты импортов (Import maps) – механизма, позволяющего получить контроль над
поведением JavaScript-импортов.

```html
<!DOCTYPE html>
<html>
  <body>
    <script type="importmap">
      {
        "imports": {
          "mylib": "./my-lib.mjs"
        }
      }
    </script>
    <script type="module">
      import { sayHi } from "mylib";

      sayHi();
    </script>
  </body>
</html>
```

## Importmap в рельсе

```sh
./bin/importmap pin jquery --from jsdelivr --download
```

Команда загрузит jquery пакет в vendor/javascript/jquery.js (за это действие отвечает
параметр `--download`).

Сформирует правило замены в config/importmap.rb
Если добавить `preload: true` в файле importmap.rb (`pin "jquery", preload: true # @3.6.3`), тогда в html добавиться:

```html
<link rel="modulepreload" href="/assets/jquery/dist/jquery-….js">
```

<!-- Необходимо в app/assets/config/manifest.js добавить `//= link jquery/dist/jquery.js` -->

## Установка Bootstrap на rails 7 (importmap)

```sh
./bin/importmap pin @popperjs/core --download
```

__Подключение scss от Bootstrap__

```sh
# Скачать bootstrap и переместить скаченный код в папку vendor/stylesheets
yarn add bootstrap
mkdir vendor/stylesheets
mv node_modules/bootstrap vendor/stylesheets
```

```rb
# Тыкнуть носом рельсу где ещё ассеты брать, файл config/initializers/assets.rb:
Rails.application.config.assets.paths << Rails.root.join("vendor", "stylesheets")
```

```sh
# Добавить в файл Gemfile:
# Use SCSS for stylesheets
gem "sass-rails"
```

```sh
# Установить гем
bundle install
```

```sh
# Поменять расширение файла app/assets/stylesheets/application.css на .scss
mv app/assets/stylesheets/application.css app/assets/stylesheets/application.scss
```

```css
/* Добавить в файл app/assets/stylesheets/application.scss */
@import "bootstrap/scss/bootstrap";
```

__Подключение js от Bootstrap__

```js
// Вообще приложение подключает так (файл app/javascript/application.js):
import "@popperjs/core"
import "bootstrap"
```

```sh
# Я скачал @popperjs/core так:
yarn add @popperjs/core
yarn add bootstrap
mkdir vendor/javascript
cp node_modules/@popperjs/core/dist/umd/popper.min.js vendor/javascript
# И bootstrap
cp node_modules/bootstrap/dist/js/bootstrap.min.js vendor/javascript
# И теперь их удалить
yarn remove @popperjs/core
yarn remove bootstrap
```

```rb
# И указываем рельсе что такое "bootstrap" и "@popperjs/core" в файле config/importmap.rb
pin "bootstrap", to: "bootstrap.min.js", preload: true
pin "@popperjs/core", to: "popper.min.js", preload: true
```
