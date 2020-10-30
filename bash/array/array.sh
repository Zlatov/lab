#!/usr/bin/env bash
# !/bin/bash

# -e Выйти немедленно, если команда выходит с ненулевым статусом.
# -x Печатать команды и их аргументы по мере их выполнения.
# -u Выйти немедленно, если было обращение к неопределённой переменной.

set -eu

# cd "$(dirname "${0}")"
cd "$(dirname "${BASH_SOURCE[0]}")"

# cd ../..

. ../_lib/echoc

# Очищаем директорию для теста:
filename=$(basename -- "${BASH_SOURCE[0]}") # Имя текущего исполняемого файла.
test_dirname="${filename%.*}" # Имя тестовой директории - это имя текущего файла без расширения.
mkdir -p ./$test_dirname
# find . -type f -not -name array.sh -delete
# find . -type d -not -path . | xargs -I {} rm -rf {}
find ./$test_dirname -type f -delete
find ./$test_dirname -type d -not -path ./$test_dirname | xargs -I {} rm -rf {}
# exit 0

array=(aaa bbb ccc)

echoc 'Вывод массива' green
unset a
declare -a a
a=("asd" "qwe zxc" 1)
echoc "первый элемент" blue
echo $a
echoc "массив в строку" blue
echo ${a[@]}
echoc "элементы построчно" blue
for i in ${!a[@]}
do
  item=${a[$i]}
  echo "$i:$item"
done
# exit 0

echoc "Вывод элемента массива" green
echo ${array[1]}              # bbb
echo ${array[10]-}             # пустая строка
echo "some text: ${array[1]}" # some text: bbb
# exit 0

echoc "Новый элемент с номером" green
array[11]=`echo "${array[1]} и ${array[2]}"`
echo ${array[11]}              # bbb и ссс
# array[-13]="ы" # вызывает ошибку если отрицатеьльное значение больше последнего_индекса+1
echo "${array[@]}"
echo "количестов: ${#array[*]}"
echo ${!a[@]} "- Это индексы"
for i in "${!array[@]}"; do
  echo "$i ${array[$i]}"
done
# exit 0

echoc 'Количество count length ${#a[@]}' green
declare -a a=('asd zxc' zxc 1)
declare -i b="${#a[@]}"
declare -i c="${#a[*]}"
declare -i d="${#a}"
echo '$a: ' "${a[@]}"
for i in ${!a[@]}
do
  value=${a[$i]}
  echoc -n $i: red; echo $value
done
echo '$b: ' $b
echo '$c: ' $c
echo '$d: ' $d '(длинна первого элемента)'
# exit 0

echoc "Новый элемент в конец массива" green
array[${#array[*]}]="не в конец ((("
echo ${array[@]}
# Добавить элемент. (переиндексация)
array123=( "${array[@]}" "новый элемент" )
echo ${array123[@]}
array123=( "${array[@]}" "новый элемент" "новый элемент2" )
echo ${array123[@]}
# exit 0

echoc "Добавить в конец" green
array123+=("новейший элемент")
echo ${array123[@]}
# exit 0

echoc "Объявление массива" green
declare -a array2
array2=("asd" "qwe zxc")
echo '$array2: ' ${array2[@]}
# exit 0

declare -a array6=( "${array[@]#*ccc}" )
echo 'array: ' ${array[@]}
echo 'array6: ' ${array6[@]}
# exit 0

declare -a array7=( ${array[@]#*ccc} )
echo 'array: ' ${array[@]}
echo 'array7: ' ${array7[@]}
# exit 0

declare -a array8=( "${array[@]/новый1/}" )
echo 'array: ' ${array[@]}
echo 'array8: ' ${array8[@]}
# exit 0

echoc "Переменная является массивом" green
unset a
a=("asd" "zxc")
if [[ "$(declare -p a)" =~ "declare -a" ]]; then echo "a is array"; else echo "a is not array"; fi
unset a
a="asd"
if [[ "$(declare -p a)" =~ "declare -a" ]]; then echo "a is array!!!"; else echo "a is not array"; fi
unset b
b="ads"
if [[ "$(declare -p b)" =~ "declare -a" ]]; then echo "b is array"; else echo "b is not array"; fi
# exit 0


echoc "Количество элементов array: ${#array[*]}" green
echoc "Количество элементов array2: ${#array2[*]}" green
# exit 0

echoc "Перебор массива с доступом к значениям value" green
for value in "${array[@]}"
do
  echo $value
done
# exit 0

echoc "Перебор массива с доступом к индесам значений index" green
for index in "${!array[@]}"
do
  echo $index
done
# exit 0

echoc "Наполним массив из файла" green
touch $test_dirname/temp
echo -e "asd\nqwe zxc" | tee $test_dirname/temp >/dev/null
unset a
declare -a a
while read line
do
  a+=("$line")
done < $test_dirname/temp
for i in ${!a[@]}
do
  item=${a[$i]}
  echo "$i:$item"
done
# exit 0

echoc "Наполним массив из файла с одной строкой (ну или с двумя) с разделением элементов пробелом." green
touch $test_dirname/temp_fil_array_from_file_one_line
echo -e "asd zxc qweqwe" > $test_dirname/temp_fil_array_from_file_one_line
echo -en "asd zxc qweqwe" >> $test_dirname/temp_fil_array_from_file_one_line
unset a
declare -a a
while read line || [ -n "$line" ]
do
  a+=($line)
done < $test_dirname/temp_fil_array_from_file_one_line
for value in "${a[@]}"
do
  echo $value
done
# exit 0

echoc "Или так" blue
unset a
mapfile -t a < $test_dirname/temp
for i in ${!a[@]}
do
  item=${a[$i]}
  echo "$i:$item"
done

echoc "Создание массива последовательности чисел" green
echoc "seq FIRST STEP LAST" blue
a=($(seq 0 0.1 2.5))
for v in "${a[@]}"
do
  echo $v
done
echo ${a[@]}
