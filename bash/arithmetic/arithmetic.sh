#!/bin/bash
. ../_lib/echoc

echoc Синтаксисы green
a=2
b=`expr $a + 1`
echo '$a: ' $a
echo '$b: ' $b

a=2
(( a *= 4 ))
echo '$a: ' $a

let "a = 4 * 1024"
echo '$a: ' $a

echoc Операторы green
a=2
let "a = $a + $a * $a"
echo '$a: ' $a # -> 6
let "a = $a / 2"
echo '$a: ' $a # -> 3
let "a = $a % 2"
echo '$a: ' $a # -> 1
let "a += 1"
echo '$a: ' $a # -> 2
let "a *= 2"
echo '$a: ' $a # -> 4
let "a /= 2"
echo '$a: ' $a # -> 2
let "a %= 2"
echo '$a: ' $a # -> 0
let "a -= 1"
echo '$a: ' $a # -> -1
let "a++"
echo '$a: ' $a # -> 0
let "++a"
echo '$a: ' $a # -> 1
let "--a"
echo '$a: ' $a # -> 0
let "a--"
echo '$a: ' $a # -> -1
let "a = ($a < 0) ? -100 : 100"
echo '$a: ' $a # -> -100


# Арифметика с плавающей точкой
# Оператор let работает только для целочисленной арифметики.
# Для арифметики с плавающей точкой использовать, например, калькулятор GNU bc:
echoc Арифметика с плавающей точкой green
echo "32.0 + 1.4" | bc
