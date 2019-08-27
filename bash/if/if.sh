#!/usr/bin/env bash
. ../_lib/echoc

# Очищаем текущую директорию для теста:
find . -type f -not -name if.sh -not -name iftest.sh -delete
find . -type d -not -path . | xargs -I {} rm -rf {}
# exit 0

# 
# If принимает выражение и проверяет статус выполнения этого выражения, т.е.
# выражение `if echo hi` будет истинно, если оно выполнится без ошибок, этого мало,
# ведь программист стремится писать безошибочный код. Оператор `[ ]` эквивалентен
# команде test позволяющей сравнивать значения. Оператор `[[ ]]` предпочтительнее,
# он встроен в bash, быстрее, позволяют использовать логические операторы `&&` или
# `||`… Внутри `(( ))` можно использовать операторы >, <, <=, >=, =, != для
# сравнения чисел.
# 
# Сравнения чисел
# -eq или = Равно.
# -ge или >=  Больше или равно.
# -ne или !=  Не равно.
# -gt или > Больше.
# -lt или < Меньше.
# -le или <=  Меньше или равно.
# 
# Проверка файлов
# -f  Существует и является файлом (не директорией).
# -d  Существует и является директорией.
# -r  Доступен для чтения.
# -w  Доступен для записи.
# -x  Файл является исполняемым.
# -O  Принадлежит текущему пользователю.
# -G  Группа идентична текущему пользователю.
# 
# Сравнение строк
# = Равенство строк.
# !=  Неравенство строк.
# < Меньше по ASCII-коду.
# > Больше по ASCII-коду.
# -n  В строке больше нуля символов.
# -z  В строке ноль символов.
# 

# [ -a FILE ] True if FILE exists.
# [ -b FILE ] True if FILE exists and is a block-special file.
# [ -c FILE ] True if FILE exists and is a character-special file.
# [ -d FILE ] True if FILE exists and is a directory.
# [ -e FILE ] True if FILE exists.
# [ -f FILE ] True if FILE exists and is a regular file.
# [ -g FILE ] True if FILE exists and its SGID bit is set.
# [ -h FILE ] True if FILE exists and is a symbolic link.
# [ -k FILE ] True if FILE exists and its sticky bit is set.
# [ -p FILE ] True if FILE exists and is a named pipe (FIFO).
# [ -r FILE ] True if FILE exists and is readable.
# [ -s FILE ] True if FILE exists and has a size greater than zero.
# [ -t FD ] True if file descriptor FD is open and refers to a terminal.
# [ -u FILE ] True if FILE exists and its SUID (set user ID) bit is set.
# [ -w FILE ] True if FILE exists and is writable.
# [ -x FILE ] True if FILE exists and is executable.
# [ -O FILE ] True if FILE exists and is owned by the effective user ID.
# [ -G FILE ] True if FILE exists and is owned by the effective group ID.
# [ -L FILE ] True if FILE exists and is a symbolic link.
# [ -N FILE ] True if FILE exists and has been modified since it was last read.
# [ -S FILE ] True if FILE exists and is a socket.
# [ FILE1 -nt FILE2 ] True if FILE1 has been changed more recently than FILE2, or if FILE1 exists and FILE2 does not.
# [ FILE1 -ot FILE2 ] True if FILE1 is older than FILE2, or is FILE2 exists and FILE1 does not.
# [ FILE1 -ef FILE2 ] True if FILE1 and FILE2 refer to the same device and inode numbers.
# [ -o OPTIONNAME ] True if shell option "OPTIONNAME" is enabled.
# [ -z STRING ] True of the length if "STRING" is zero.
# [ -n STRING ] or [ STRING ] True if the length of "STRING" is non-zero.
# [ STRING1 == STRING2 ]  True if the strings are equal. "=" may be used instead of "==" for strict POSIX compliance.
# [ STRING1 != STRING2 ]  True if the strings are not equal.
# [ STRING1 < STRING2 ] True if "STRING1" sorts before "STRING2" lexicographically in the current locale.
# [ STRING1 > STRING2 ] True if "STRING1" sorts after "STRING2" lexicographically in the current locale.

echo 'asd' > temp
if [[ -f temp &&  -r temp ]] && egrep -q "^asd" temp
then
  echoc yes green
else
  echoc no red
fi
# exit 0

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

a="string"
if [ $a = "string" ]
then
  echoc 'Значение переменной a равно "string"' green
else
  echoc 'Значение переменной a не равно "string"' red
fi
a="string"
if [[ ! "$a" = "string" ]]
then
  echoc 'Значение переменной a не равно "string"' red
else
  echoc 'Значение переменной a равно "string"' green
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

echoc "if в строку" green
echoc 'О подпроцессах можно почитать тут /bash/$?/$?.sh' blue
echoc 'Код снимающий ошибку: `|| echo &>/dev/null`' green
touch temp
[[ -f temp ]] && rm ./tem && rm ./temp || echo &>/dev/null
echo $?
[[ -f tem ]] && rm ./temp || echo &>/dev/null
echo $?
[[ -f tem ]] && rm ./temp || echo &>/dev/null
echo $?
echoc "Done." green
