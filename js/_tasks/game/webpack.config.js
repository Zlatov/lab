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
    publicPath: "/dist"
  },
  devServer: {
    static: {
      directory: path.join(__dirname),
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
          {loader: "css-loader", options: {importLoaders: 2}},
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
            context: "src/img",
            // name: "[name].[ext]",
            name: "[path][name]-[contenthash].[ext]",
            // name: "[name]-[contenthash].[ext]",
            // name: "[path][name].[ext]",
            outputPath: "images",
            // publicPath: "/",
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
