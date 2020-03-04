"use strict"

var node_env = null
switch (process.env.NODE_ENV) {
  case null:
  case undefined:
  case "development":
  node_env = "development"
  break
  case "production":
  node_env = "production"
  break
  default:
  throw new Error("Не удалось определить окружение.")
}

const NODE_ENV = node_env
const is_development = NODE_ENV == "development"
const is_production = NODE_ENV == "production"
const webpack = require("webpack")
const path = require("path");
const MiniCssExtractPlugin = require("mini-css-extract-plugin")
const glob = require("glob");

module.exports = {
  mode: NODE_ENV,
  context: path.resolve(__dirname, "javascript"),
  entry: "./js.js",
  output: {
    path: path.resolve(__dirname, "temp_public"),
    filename: "js.js"
  },
  watch: is_development,
  watchOptions: {
    aggregateTimeout: 300,
  },
  devtool: is_development ? "cheap-inline-module-source-map" : false,
  plugins: [
    new webpack.EnvironmentPlugin(["NODE_ENV"]),
    new webpack.ProvidePlugin({
      $: "jquery",
      jQuery: "jquery",
      jquery: "jquery",
      "window.$": "jquery",
      "window.jQuery": "jquery",
      "window.jquery": "jquery"
    }),
    new MiniCssExtractPlugin({
      filename: "css.css",
      ignoreOrder: false,
    })
  ],
  optimization: {
    minimize: is_development ? false : true,
    noEmitOnErrors: true,
  },
  module: {
    rules: [
      {
        test: /\.m?jsx?$/,
        exclude: /(node_modules)/,
        use: {loader: "babel-loader", options: {presets: ["@babel/preset-env"], plugins: ["@babel/plugin-transform-runtime"]}}
      },
      {
        test: /\.(sa|sc|c)ss$/i,
        use: [
          {loader: MiniCssExtractPlugin.loader, options: {hmr: is_development}},
          {loader: "css-loader", options: {importLoaders: 1}},
          {loader: "postcss-loader", options:{options: {}}},
          {loader: "sass-loader", options: {implementation: require("node-sass")}}
        ]
      },
      {
        test: /\.(png|jpe?g|gif|svg)$/i,
        use: [
          {loader: "file-loader", options: {name: "[name].[ext]", outputPath: "images", publicPath: "images"}},
        ],
      },
      {
        test: /\.(woff|woff2|ttf|otf|eot)$/i,
        use: [
          {loader: "file-loader", options: {name: "[path][name].[ext]"}}
        ]
      }
    ]
  }
}
