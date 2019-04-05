"use strict"

// Возьмём переменную окружения и определим желаемую конфигурацию ("development" || "production")
var _node_env
switch (process.env.NODE_ENV) {
  case "development":
  case null:
  case undefined:
  _node_env = "development"
  break;
  case "production":
  _node_env = "production"
  break;
  default:
  throw new Error("Не удалось определить окружение.")
  break;
}
const NODE_ENV = _node_env

// Для загрузки плагинов присоединим локально установленный модуль webpack
const webpack = require("webpack")

module.exports = {
  mode: NODE_ENV,
  entry: "./app.js",
  output: {
    // path: path.resolve(__dirname, 'dist'),
    path: __dirname,
    filename: "assets/temp_build.js",

    library: "app", // app - имя переменной в которую помещается экспорт пакета app.
  },

  watch: NODE_ENV == "development",
  watchOptions: {
    aggregateTimeout: 300, // 300 - задержка перед запуском компиляции после сохранения.
  },

  devtool: NODE_ENV == "development" ? "cheap-inline-module-source-map" : false, // source-map - билдит .map файл для разбиения на модули в дебагере.

  plugins: [
    // Делает доступными переменные окружения в приложении с именами process.env.VAR_NAME
    new webpack.EnvironmentPlugin(["NODE_ENV", "USER"]),
    // Делает доступными переменные из сборки в приложении с заданными именами
    new webpack.DefinePlugin({
      NODE_ENV: JSON.stringify(NODE_ENV),
      LANG: '"ru"',
    })
  ],

  optimization: {
    minimize: NODE_ENV == "development" ? false : true, // false - не минимизировать.
  },

  module: {
    rules: [
      // ES6 в ES5 (babel)
      // npm install -D babel-loader @babel/core @babel/preset-env webpack
      {
        test: /\.m?js$/,
        exclude: /(node_modules)/,
        use: {
          loader: "babel-loader",
          // npm i @babel/plugin-transform-runtime
          options: {
            // Вынести дополнительный функционал ES6 в отдельный модуль, а не дополнять в каждый загружаемый модуль.
            plugins: ['@babel/plugin-transform-runtime']
          }
        }
      }
    ]
  },

  // Как (где) webpack будет искать модули и лоадеры:
  // resolve: {
  //   modules: ["node_modules"],
  //   extensions: [".js"],
  // },
  // resolveLoader: {
  //   modules: ["node_modules"],
  //   extensions: [".js"],
  // },
}
