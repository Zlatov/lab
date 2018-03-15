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

# Мультистроковая строка multyline string
echoc 'Мультистроковая строка multyline string' green
# Однострочное считывание
echo $'line1\nline2'
echo "обломс\nобломс\n"
echo -e 'line1\nline2'
# Многострочное считывание
a="
  не
  очень
  такой
  метод
"
echo "$a"

echo "$(cat <<-GG
Нужно помнить:
  — при выводе мультистроковых строк необходимо обернуть их в двойные кавычки:
  echo "$MULTILINE_VALUE"
  — чтобы вывести строку в которой переносы заданы символами '\' и 'n' (бугага), нужно использовать параметр -e:
  echo -e 'line1\nline2\n'
GG
)"

a=$(cat << GG
  3
  4
GG
)
echo '$a:'
echo "$a"
