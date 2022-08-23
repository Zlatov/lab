"use strict"

const webpack = require("webpack")
const path = require("path");
const NODE_ENV = process.env.NODE_ENV == "production" ? "production" : "development"
const MiniCssExtractPlugin = require("mini-css-extract-plugin")
// const HtmlWebpackPlugin = require("html-webpack-plugin")

console.log('Конфигурация вебпак отрабатывает в окружении NODE_ENV: ', NODE_ENV)

module.exports = {
  entry: "./src/index.js",
  output: {
    path: path.resolve(__dirname, "dist"),
    filename: "main.js",
    publicPath: "/dist/"
  },
  devServer: {
    static: {
      directory: "./",
    },
    hot: true
  },
  watchOptions: {
    aggregateTimeout: 300
  },
  devtool: NODE_ENV == "development" ? "inline-cheap-module-source-map" : false,
  module: {
    rules: [
      {
        test: /\.(sa|sc|c)ss$/i,
        use: [
          {loader: MiniCssExtractPlugin.loader, options: {}},
          {loader: "css-loader", options: {importLoaders: 2, esModule: false}},
          {loader: "postcss-loader", options: {sourceMap: true}},
          {loader: "sass-loader", options: {implementation: require("node-sass")}}
        ]
      },
      // {
      //   test: /\.html$/i,
      //   use: ["html-loader"]
      // },
      {
        test: /\.(png|jpg|jpeg|gif|svg)$/i,
        use: [
          {loader: "file-loader", options: {
            // name: "[path][name]-[contenthash].[ext]",
            name: "[name]-[contenthash].[ext]",
            // Мы решили хранить все файлы загруженные данным лоадером в
            // подпапке images, итоговый путь dist/images.
            outputPath: "images",
            // Пути к изображениям в сгенерированных css-файлах
            // (dist/main.css) должны начинаться с `images/...`, а не с
            // `dist/images`, так как сами css-файлы уже лежат в dist.
            publicPath: "images/"
          }}
        ]
      }
    ]
  },
  plugins: [
    new webpack.ProvidePlugin({
      $: "jquery",
      jQuery: "jquery"
    }),
    new MiniCssExtractPlugin({
      ignoreOrder: false
    }),
    // new HtmlWebpackPlugin({
    //   template: "./src/index.html",
    //   // publicPath: "img",
    //   showErrors: true
    // })
  ]
}
