# Bootstrap

```sh
yarn add bootstrap
yarn add @popperjs/core
yarn add bootstrap-icons
```

```js
// app/assets/stylesheets/application.scss
@import "./bootstrap_variables";
@import "bootstrap/scss/bootstrap";
@import "./bootstrap_fixes";

// app/javascript/packs/application.js
import "bootstrap"
import "bootstrap-icons/font/bootstrap-icons.css"
```

## Медиа-запросы

Отличия `@media (min-width: …)` от `@media (max-width: …)`

`min-width: value` - Срабатывают при экранах ширина которых Больше указанной.
Таким образом назначающий класс `custom-lg` будет срабатывать на экранах lg,
xl, xxl. Верстая классами размещёнными в min-width, получается кастомизируешь
отображения на десктопных устройствах.

`max-width: value` - Срабатывает на малых экранах, размещая такой же класс
`custom-lg` в max-width, получаем кастомизацию отображения на мобильных
устройствах.

Bootstrap в основном использует min-width стратегию, то есть изначально вёрстка
мобильная, назначаются кастомизацтонные классы для десктопного отображения.

Однако это не означает, что такая стратегия «единственно правильная».

Пример отменяющего класса (отменяющий класс срабатывает на бОльших экранах),
поэтому стиль назначающего класса срабатывает на меньших!:

```css
// 
// Отменяющие стили для границ
// Используются совместно с назначающим стилем, например:
// border-top border-top-0-lg
// - отрисует границу при экранах: sm, md
// 

// Small devices (landscape phones, 576px and up)
@media (min-width: 576px) {
  .border-top-0-sm {border-top: none!important;}
  .border-bottom-0-sm {border-bottom: none!important;}
  .border-start-0-sm {border-left: none!important;}
  .border-end-0-sm {border-right: none!important;}
}

// Medium devices (tablets, 768px and up)
@media (min-width: 768px) {
  .border-top-0-md {border-top: none!important;}
  .border-bottom-0-md {border-bottom: none!important;}
  .border-start-0-md {border-left: none!important;}
  .border-end-0-md {border-right: none!important;}
}

// Large devices (desktops, 992px and up)
@media (min-width: 992px) {
  .border-top-0-lg {border-top: none!important;}
  .border-bottom-0-lg {border-bottom: none!important;}
  .border-start-0-lg {border-left: none!important;}
  .border-end-0-lg {border-right: none!important;}
}

…
…
…

```
