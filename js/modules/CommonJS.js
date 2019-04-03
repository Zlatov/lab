;(function() {

  "use strict"

  function myModule() {
    this.hello = function() {
      return 'hello!';
    }
    this.goodbye = function() {
      return 'goodbye!';
    }
  }

  module.exports = myModule;

}());
