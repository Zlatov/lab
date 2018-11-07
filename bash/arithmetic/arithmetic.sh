#!/bin/bash
. ../_lib/echoc

set -eu

echoc Синтаксисы green
a=2
b=`expr $a + 1`
echo '$a: ' $a
echo '$b: ' $b

a=2
(( a *= 4 ))
echo '$a: ' $a

# Инстина если не нуль
echoc "Инстина если не нуль" green
(( 0 )) && echo '0'
(( 1 )) && echo '1'
(( 2 )) && echo '2'

# Инстина если переменная меньше числа
echoc "Инстина если переменная меньше числа" green
a=-2
(( $a < -1 )) && echoc true green || echoc false red
# exit 0

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
# let "a %= 2"
echo '$a: ' $a # -> 0
let "a -= 1"
echo '$a: ' $a # -> -1
# let "a++"
echo '$a: ' $a # -> 0
let "++a"
echo '$a: ' $a # -> 1
# let "--a"
echo '$a: ' $a # -> 0
let "a--"
echo '$a: ' $a # -> -1
let "a = ($a < 0) ? -100 : 100"
echo '$a: ' $a # -> -100


# Арифметика с плавающей точкой
# Оператор let работает только для целочисленной арифметики.
# Для арифметики с плавающей точкой использовать, например, калькулятор GNU bc:
echoc "Арифметика с плавающей точкой" green
echo "32.0 + 1.4" | bc

a=10
# Генерит ошибку на нулях
# let "b = a % 10"
# if [[ $b = 0 ]]; then
# 	echo 'DA'
# fi
# echo '$a: ' $a
# echo '$b: ' $b

# Не генерит ошибку на нулях
i=10
os=$(($i%10))
echo $os

# Инкремент переменной
echoc "Инкремент переменной" green
a=1
a=$(( a+1 ))
echo '$a: ' $a
((a=a+1))
echo '$a: ' $a
(( a = a + 1 ))
echo '$a: ' $a
(( a+=1 ))
echo '$a: ' $a
(( a += 1 ))
echo '$a: ' $a
(( a++ ))
echo '$a: ' $a
(( a ++ ))
echo '$a: ' $a
