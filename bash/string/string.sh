#!/usr/bin/env bash

. ../_lib/echoc

# Замена
echoc Замена green
a="foobarfoofoo"
b=${a/oo/aa}
echo $a
echo $b

# Замена в файле `replace` (от MySQL)
# В состав MySQL входит утилита replace, которая умеет производить замену в файле:
# Она умеет менять пары подстрок, что позволяет производить такие замены:
# echo ABBA | replace A B B A  --
# BAAB
echoc 'Замена в файле `replace` (от MySQL)' green
touch temp
echo "asd zxc" | tee temp >/dev/null
replace 'd z' 'dd zz' -- temp
# exit 0

# Вывод переменных в строке
echoc 'Вывод переменных в строке' 'green'
a='0'
aa='0'
echo "a${a}aa"

# Длинна строки
echoc "Длинна строки" green
a=asdzxcqwe
echo ${#a}
echo `expr length $a`
echo `expr "$a" : '.*'`
# exit 0

# Индекс символа в строке
echoc "Индекс символа в строке" green
a=asdzxcqwe
# 123456789
b=`expr index "$a" as`
c=`expr index "$a" zx`
d=`expr index "$a" q0`
e=`expr index "$a" 0q`
f=`expr index "$a" 01`
echo '$a: ' $a
echo '$b: ' $b
echo '$c: ' $c
echo '$d: ' $d найден один из символов
echo '$e: ' $e найден один из символов
echo '$f: ' $f не найден ни один из символов
# exit 0

# Индекс подстроки в строке
echoc "Индекс подстроки в строке" green
a=asdzxcqwe
# 123456789
b="${a%%zxc*}"
c=${#b}
i=$( temp="${a%%zxc*}" && [[ "$temp" = "$a" ]] && echo -1 || echo "${#temp}" )
echo '$a: ' $a
echo '$b: ' $b "удалить с конца всё что нашлось с подстроки и до конца (zxc*)"
echo '$c: ' $c "количество оставшегося есть индекс"
echo '$i: ' $i
# exit 0

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

# Отбросить известную часть с начала
echoc "Отбросить известную часть с начала" green
a="asd/zxc/qwe"
b=${a##asd/zxc/}
echo '$a: ' $a
echo '$b: ' $b

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

echo asdfasdfasdf
a=asd
a+=
echo '$a:' $a
PGPASSWORD="lorem_rails_password" psql -U lorem_rails -c "\
  SELECT * FROM stat;\
"
