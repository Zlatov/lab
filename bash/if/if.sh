#!/usr/bin/env bash

. ../_lib/echoc

a=1
if [[ "$a" -eq 1 ]]
then
  echoc "Значение переменной a эквивалентно 1" green
  if [[ ! "$a" -eq 2 ]]; then echoc -n " и не эквивалентно 2."; fi
else
  echoc "Значение переменной a не эквивалентно 1" red
fi
# exit 0

a=true
if $a
then
  echoc 'Значение переменной a эквивалентно true' green
else
  echoc 'Значение переменной a не эквивалентно true' red
fi
a=true
if [[ ! "$a" = true ]]
then
  echoc 'Значение переменной a не эквивалентно true' red
else
  echoc 'Значение переменной a эквивалентно true' green
fi
# exit 0

# Условные выражения,
# такие как [ "$x" = "$y" ], [ -e "$file" ], [ -n "$variable" ] проверка, является ли переменная пустой
if [ $BOO = false ]
  then
    echo '[1]'
  else
    echo '[0]'
fi

a=''
if [[ ! "$a" = '' ]]
then
  echo 'a: не пустая строка.'
else
  echo 'a: пустая строка.'
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

STRING='asd\nasd'
if (( `echo -e $STRING | grep -c a` >= 3 ))
then
  echo 'много'
elif (( `echo -e $STRING | grep -c a` == 2 ))
then
  echo 'два'
elif (( `echo -e $STRING | grep -c a` == 1 ))
then
  echo 'один'
else
  echo 'нет'
fi

a='if.sh'
# if [ -f ./if.sh ]
if [ -f $a ]
then
  echoc 'файл if.sh есть' green
else
  echoc 'файла if.sh нет' red
fi

# $ command -v foo >/dev/null 2>&1 || { echo >&2 "I require foo but it's not installed.  Aborting."; exit 1; }
# $ type foo >/dev/null 2>&1 || { echo >&2 "I require foo but it's not installed.  Aborting."; exit 1; }
# $ hash foo 2>/dev/null || { echo >&2 "I require foo but it's not installed.  Aborting."; exit 1; }

if hash foo 2>/dev/null
then
  echoc "Программа foo найдена." green
else
  echoc "Программа foo не найдена." red
fi
