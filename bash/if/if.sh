#!/bin/bash
. ../_lib/yn

Yn "Да? [YES/no]"

if [[ $YN -eq 1 ]]
  then
    BOO=true
  else
    BOO=false
fi

if !($BOO)
  then
    echo '(1)'
  else
    echo '(0)'
fi

# Условные выражения,
# такие как [ "$x" = "$y" ], [ -e "$file" ], [ -n "$variable" ] проверка, является ли переменная пустой
if [ $BOO = false ]
  then
    echo '[1]'
  else
    echo '[0]'
fi
# но не больше/меньше см арифметические выражения
a=18
if [ $a = 18 ]
  then
    echo '[18]'
  else
    echo '[not18]'
fi

# Сравнение чисел с плавающей точкой
if [ $(echo "2.1<2.2"|bc) = 1 ]; then echo "correct"; else echo "wrong"; fi

# Арифметические выражения
age=100
if (( $age >= 21 )); then echo "Let's talk about sex."; fi
