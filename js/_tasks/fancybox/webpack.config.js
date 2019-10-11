"use strict"

// Из значения переменной окружения NODE_ENV определим тип окружения: "development" || "production"
var node_env
if (process.env.NODE_ENV != null) {
  switch (process.env.NODE_ENV) {
    case "development":
    case null:
    case undefined:
    node_env = "development"
    break;
    case "production":
    node_env = "production"
    break;
    default:
    throw new Error("Не удалось определить окружение.")
    break;
  }
} else {
  node_env = "development"
}
const NODE_ENV = node_env
var glob = require("glob");

// Для загрузки плагинов присоединим локально установленный модуль webpack
const webpack = require("webpack")
const MiniCssExtractPlugin = require('mini-css-extract-plugin')

module.exports = {
  mode: NODE_ENV,
  // Общий путь всех точек входа
  // entry: glob.sync("./javascript/*.js"),
  entry: "./javascript/js.js",
  output: {
    // Общий путь для точек выхода.
    path: __dirname + "/temp_public/packs",
    // publicPath: "assets/webpack/",
    filename: "js.js",
    // library: "[name]", // имя переменной в которую помещается экспорт основных пакетов (точек входа).
  },

  watch: NODE_ENV == "development",
  watchOptions: {
    aggregateTimeout: 300, // 300 - задержка перед запуском компиляции после сохранения.
  },

  // source-map - билдит .map файл для разбиения на модули в дебагере.
  // cheap-inline-... встаялет map в билда, без приставки генерит отдельно.
  devtool: NODE_ENV == "development" ? "module-source-map" : false,

  plugins: [
    // Делает доступными переменные окружения в приложении с именами process.env.VAR_NAME
    new webpack.EnvironmentPlugin(["NODE_ENV"]),
    // Делает доступными переменные из сборки в приложении с заданными именами
    new webpack.DefinePlugin({
      NODE_ENV: JSON.stringify(NODE_ENV),
      LANG: '"ru"',
    }),
    // Автоматически подключает библиотеки если видит неинициализированные имена переменных
    // Рекомендуется использовать глобальных библиотек которые нужны почти везде. 
    new webpack.ProvidePlugin({
      $: "jquery",
      "window.$": "jquery",
      jQuery: "jquery",
      "window.jQuery": "jquery",
      jquery: "jquery",
      "window.jquery": "jquery"
    }),
    new MiniCssExtractPlugin({
      filename: 'css.css',
      // chunkFilename: '[id].css',
      ignoreOrder: false,
    }),
    // // Общая часть всех точек входа будет выделена в common.js это позволит закешиться общей части и ускорить загрузку.
    // new webpack.optimize.CommonsChunkPlugin({
    //   name: "common"
    // })
  ],

  optimization: {
    // false - не минимизировать:
    minimize: NODE_ENV == "development" ? false : true,
    // true - не создавать файлы если происходит ошибка при компиляции:
    noEmitOnErrors: true,
    // // // Общая часть всех точек входа будет выделена в common.js это позволит закешиться общей части и ускорить загрузку.
    // splitChunks: {
    //   name: true
    // }
  },

  module: {
    // Не просматривать данные файлы на require|import - что ускоряет сборку:
    noParse: /jquery|lodash|angular/,
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
      },
      // {
      //   test: /\.s[ac]ss$/i,
      //   use: [
      //     'style-loader',
      //     'css-loader',
      //     'sass-loader',
      //   ],
      // },
      {
        test: /\.(sa|sc|c)ss$/i,
        use: [
          {
            loader: MiniCssExtractPlugin.loader,
            options: {
              hmr: NODE_ENV === 'development',
            },
          },
          'css-loader',
          // 'postcss-loader',
          {
            loader: `postcss-loader`,
            options: {
              options: {},
              // plugins: () => {
              //   autoprefixer({ browsers: [ 'last 2 versions' ] })
              // }
            }
          },
          'sass-loader'
        ],
      },
      // CSS loader
      // npm i style-loader css-loader
      // {
      //   test: /\.css$/,
      //   use: [
      //     {
      //       loader: 'style-loader',
      //       options: {
      //         // convertToAbsoluteUrls: true,
      //       }
      //     },
      //     {
      //       loader: 'css-loader',
      //     }
      //   ],
      // },
      // File loader
      // npm i file-loader
      {
        test: /\.(png|jpg|gif)$/i,
        use: [
          {
            loader: 'file-loader',
            options: {
              name: '[path][name].[ext]',
            },
          },
        ],
      }
      // // Url loader
      // // Преобразует в base64 data-url при допустимых размерах.
      // // npm i url-loader
      // {
      //   test: /\.(png|jpg|gif)$/i,
      //   use: [
      //     {
      //       loader: 'url-loader',
      //       options: {
      //         limit: 4096
      //       },
      //     },
      //   ],
      // }
    ]
  },

  // Как (где) webpack будет искать модули и лоадеры:
  // resolve: {
  //   modules: ["../../../node_modules"],
  //   extensions: [".js"],
  // },
  // resolveLoader: {
  //   modules: ["../../../node_modules"],
  //   extensions: [".js"],
  // },
}
