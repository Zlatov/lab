#!/bin/bash
. ../_lib/echoc

# Замена
echoc Замена green
a="foobarfoofoo"
b=${a/oo/aa}
echo $a
echo $b

# Вывод переменных в строке
echoc 'Вывод переменных в строке' 'green'
a='0'
aa='0'
echo "a${a}aa"


# Вырезать по позиции
echoc 'Вырезать по позиции' 'green'
A="foobar"
B=${A:2:2}
echo 'A = ' $A # -> foobar
echo 'B = ' $B # -> ob


# Обрезать конец/начало указав конец/начало
echoc 'trailing/leading substitution (Обрезать конец/начало указав конец/начало, бредовый функционал?)' 'green'
A="foobarbar"
B=${A%bar}
echo 'A = ' $A # -> foobarbar
echo 'B = ' $B # -> foobar
A="foofoobar"
B=${A#foo}
echo 'A = ' $A # -> foofoobar
echo 'B = ' $B # -> foobar
