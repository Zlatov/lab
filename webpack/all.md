# Webpack

## Установка

`sudo npm i -g webpack`

__Проверка установки__

```
$ webpack -v
4.29.6
$ which webpack
/usr/local/bin/webpack
```


## Настройка

https://dev.to/pixelgoo/how-to-configure-webpack-from-scratch-for-a-basic-website-46a5


## Анализ

На [сайт](http://webpack.github.io/analyse/) загрузить json файл сегенерированный `./bin/webpack --json --profile > tmp/webpack-stat.json`

Просмотр всех ресурсов webpack: http://localhost:5000/webpack-dev-server


## В rails

* `./bin/webpack-dev-server`
* `./bin/webpack-dev-server --verbose` - в подробном режиме.
* `./bin/webpack-dev-server --profile` - показывает, сколько времени потребовалось для каждого из пакетов.
