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

## Bootstrap

```sh
./bin/importmap pin @popperjs/core --download
```
