"use strict"

var a = 3
switch(a) {
  case 1:
  console.log("1!")
  case 2: // Начнёт выполнять код далее. Нельзя указывать значения через запятую.
  console.log("2!")
  case 3: // Продолжит выполнение (нет break).
  console.log("3!")
  break // Прервёт выполнение.
  case 2: // "Ещё раз начнёт?" — нет.
  console.log("2!!")
  break
  default:
  console.log("Default: none.")
}
// return

switch(true) {
  case false:
  console.log("1!")
  case 1: // 1 не true.
  console.log("2!")
  case 1 > 0: // Начнёт выполнять код далее.
  console.log("3!")
  break // Прервёт выполнение.
  default:
  console.log("Default: none.")
}
// return
