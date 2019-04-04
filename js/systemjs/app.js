"use strict"

// Глобальная область видимтоси доступна
console.log('window: ', window)

// Но не засоряется var var_name
var a = 1

// Можно подключить модуль по пути
var MyModule = require("./MyModule.js")
console.log('MyModule: ', MyModule)

// Можно подключить по map SystemJS
var $ = require("jquery")
console.log('$: ', $)

// Какой-то обект
var app = new (function() {
  this.version = "1.0.0"
})

// То что вернёт модуль
module.exports.app = app;
