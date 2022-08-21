"use strict"

const webpack = require("webpack")
const path = require("path");
const NODE_ENV = process.env.NODE_ENV == "production" ? "production" : "development"

module.exports = {
  entry: "./src/index.js",
  output: {
    path: path.resolve(__dirname, "dist"),
    filename: "main.js"
  },
  devServer: {
    static: {
      directory: path.join(__dirname, 'dist'),
    },
    hot: true
  },
  watchOptions: {
    aggregateTimeout: 300
  },
  devtool: NODE_ENV == "development" ? "inline-cheap-module-source-map" : false,
  plugins: [
    new webpack.ProvidePlugin({
      $: "jquery",
      jQuery: "jquery"
    })
  ],
}
