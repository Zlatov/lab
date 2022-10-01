# Подключение шрифтов к рельсе

Положить шрифты в `app/assets/fonts/*.ttf`

В основном файле сначала подгрузить шрифты для их дальнейшего использования
(`@import "./fonts.scss";`).

```sass
/* app/assets/stylesheets/admin/application.scss */
@import "./fonts.scss";
@import "./bootstrap_variabless.scss";
@import "bootstrap/scss/bootstrap";
```

```sass
/* app/assets/stylesheets/admin/fonts.scss */
@font-face {
  font-family: 'SourceSansPro';
  src: font-url('SourceSansPro-Regular.ttf') format('truetype');
  font-weight: normal;
  font-style: normal;
}

@font-face {
  font-family: 'SourceSansPro-Light';
  src: font-url('SourceSansPro-Light.ttf') format('truetype');
  font-weight: 100;
  font-style: normal;
}

@font-face {
  font-family: 'SourceSansPro-Bold';
  src: font-url('SourceSansPro-Bold.ttf') format('truetype');
  font-weight: 700;
  font-style: normal;
}
```

Пренастройка шрифтов bootstrap 5

```sass
/* app/assets/stylesheets/admin/bootstrap_variabless.scss */

// Пренастройка шрифтов bootstrap
$font-family-sans-serif: SourceSansPro, system-ui, -apple-system, "Segoe UI", "Helvetica Neue", Arial, sans-serif;
$font-size-base: 0.875rem;
```
