;(function() {
  'use strict'

  // 
  // Что такое prototype
  // это объект,
  // назначаемый (при необходимости) конструкторам (функциям - классам),
  // все инстансы будут иметь свойства прототипа (да неужели)
  // 
  // Собственно корректно общие вещи для всех инстансов класть в прототип,
  // а не прописывать общие функции при инициализации (в конструкторе):
  // 
  // window.MyClass.prototype.activate = f () {}
  // а не window.MyClass = f () { this.activate = f () {} }
  // 

  window.Car = function() {
    this.serial_number = Date.now()
    this.start = function() {
      console.log('> this.start')
      console.log('this: ', this)
    }
    // debugger;

    // Доступ из инстанса к классу конструктрору и его статическим методам:
    // this.constructor.go1()
  }

  // А это по сути статический метод класса не имеющий отношения к экземлярам объектов
  // скорее это похоже на функциональное программирование.
  window.Car.go1 = function() {
    console.log('> window.Car.go')
    console.log('this: ', this)
  }

  // Вот добавляем в прототип свойство,
  // добавляем аккуратно а не: window.Car.prototype = { go: function() { ... } }, а только новое свойство.
  // Прототип есть по умолчанию у всех создаваемых инстансов и обычно содержит свойство constructor указывающий на функцию-класс создателя
  window.Car.prototype.go2 = function() {
    console.log('> window.Car.prototype.go')
    console.log('this: ', this)
    debugger;
  }

  window.cars = []
  window.cars.push(new window.Car())

  console.log('window.cars[0]: ', window.cars[0])
  console.log('window.cars[0].go1: ', window.cars[0].go1)
  console.log('window.cars[0].go2: ', window.cars[0].go2)

})();
