"use strict"

function MyModule() {
  this.greeting = function(lang=null) {
    return 'Привет, Мир!';
  }
}

module.exports.MyModule = MyModule;
