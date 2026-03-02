# Rails pipeline

Pipeline работает в два этапа: поиск ассетов в списке источников и публикация ассетов.

1.  Объяви где лежат ассеты `config/initializers/assets.rb` => pipeline сможет
    находить файлы для хелперов и обработки CSS, создастся список источников
    ассетов.
2.  Объяви какие публиковать `app/assets/config/manifest.js` => файлы будут
    скопированы в public/assets (станут доступны браузеру).
3.  Pipeline автоматически перезапишет пути в url() с подстановкой fingerprint,
    если файл опубликован (2) и найден в списоке источников (1).


## 1. Где лежат ассеты

Pipeline Rails может находить файлы в указанных директориях, но файлы ещё НЕ публикуются.

```rb
# config/initializers/assets.rb

Rails.application.config.assets.paths << Rails.root.join("app/assets/fonts")
Rails.application.config.assets.paths << Rails.root.join("app/assets/builds")
```

Что это означает для pipeline:

*   ищи здесь файлы при обработке хелперов и CSS.

Что это означает для программиста:

*   можно использовать хелперы, например `asset_path "images/logo.svg"` или `image_tag "images/logo.svg"`,
*   файл ещё может быть не доступен браузеру, его нужно публиковать,
*   если файл опубликован, то результирующий url к нему с fingerprint.


## 2. Какие публикуются

Pipeline публикует только те файлы, которые объявлены в manifest.js. Директории
нет в manifest.js => файл не доступен браузеру.

```js
// app/assets/config/manifest.js

//= link_tree ../images
//= link_tree ../fonts
//= link_tree ../builds
```

Что это означает для pipeline:

*   положи файлы из директории в public/assets.

Что это означает для программиста:

*   файл будет доступен браузеру по `/assets/...`
*   если файл в списке источников ассетов, то путь к файлу с fingerprint,
*   если файл НЕ в списке источников ассетов, то путь к файлу без fingerprint и останется как есть.


## Контроль

```rb
# Список источников ассетов
Rails.application.assets.load_path.paths

# Манифест замены путей с fingerprint
# 
# В режиме разработки public/assets/.manifest.json не всегда доступен и никогда
# не является источником правды если доступен.
# 
# В продакшн режиме может быть доступен по url /assets/.manifest.json, в консоле
Rails.application.assets.manifest.path
# или на диске
ls public/assets/.manifest.json
```
