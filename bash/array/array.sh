#!/usr/bin/env bash
# !/bin/bash

set -eu

. ../_lib/echoc

cd `dirname "$0"`
array=(aaa bbb ccc)

# Вывод массива
echo "\n"
echoc 'Вывод массива' green
echo $array                   # aaa - не выведет массив
echo ${array[@]}              # aaa bbb ccc - выведет массив

# Вывод элемента массива
echo ${array[1]}              # bbb
echo ${array[10]}             # пустая строка
echo "some text: ${array[1]}" # some text: bbb

# Новый элемент с номером
array[11]=`echo "${array[1]} и ${array[2]}"`
echo ${array[11]}              # bbb и ссс
# array[-13]="ы" # вызывает ошибку если отрицатеьльное значение больше последнего_индекса+1
echo "${array[@]}"
echo "количестов: ${#array[*]}"
echo ${!a[@]} "- Это индексы"
for i in "${!array[@]}"; do
  echo "$i ${array[$i]}"
done
exit 0

# Количество count length
echoc "Количество count length" green
declare -a a=('asd zxc' zxc 1)
declare -i b="${#a[@]}"
declare -i c="${#a[*]}"
declare -i d="${#a}"
echo '$a: ' "${a[@]}"
echo '$b: ' $b
echo '$c: ' $c
echo '$d: ' $d '(длинна первого элемента)'
# exit 0

# Новый элемент в конец массива
array[${#array[*]}]="не в конец ((("
echo ${array[@]}
# Добавить элемент. (переиндексация)
array123=( "${array[@]}" "новый элемент" )
echo ${array123[@]}

# Добавить в конец
array123+=("новейший элемент")
echo ${array123[@]}
# exit 0

# Объявление массива
declare -a array2
echo 'array2: ' ${array2[@]}

declare -a array6=( "${array[@]#*ccc}" )
echo 'array6: ' ${array6[@]}

declare -a array7=( ${array[@]#*ccc} )
echo 'array7: ' ${array7[@]}

declare -a array8=( "${array[@]/новый1/}" )
echo 'array8: ' ${array8[@]}

# Переменная является массивом
echoc "Переменная является массивом" green
a=(asd zxc)
if [[ "$(declare -p a)" =~ "declare -a" ]]; then echo "a is array"; else echo "a is not array"; fi
a=string
if [[ "$(declare -p a)" =~ "declare -a" ]]; then echo "a is array!!!"; else echo "a is not array"; fi
b=string
if [[ "$(declare -p b)" =~ "declare -a" ]]; then echo "b is array"; else echo "b is not array"; fi
exit 0


echo "Количество элементов array: ${#array[*]}" # ... 4
echo "Количество элементов array2: ${#array2[*]}" # ... 0

echo 
echo "--- \"\${array[@]}\" --- as value"
echo 
for value in "${array[@]}"
do
	echo $value
done

echo 
echo "--- \"\${!array[@]}\" --- as key"
echo 
for key in "${!array[@]}"
do
	echo $key
done

echo 
echo "printf array"
echo 
for index in "${!array[@]}"
do
	printf '%d %s\n' "$index" "${array[$index]}"
done

echo 
echo "6:"
echo 
for index in "${!array6[@]}"
do
	printf '%d %s\n' "$index" "${array6[$index]}"
done

echo 
echo "7:"
echo 
for index in "${!array7[@]}"
do
	printf '%d %s\n' "$index" "${array7[$index]}"
done

echo 
echo "8:"
echo 
echoc 'Перебор массива array8' green
for index in "${!array8[@]}"
do
  printf '%d %s\n' "$index" "${array8[$index]}"
done

echo
echoc 'Перебор массива array123' green
for index in "${!array123[@]}"
do
	printf '%d %s\n' "$index" "${array123[$index]}"
done
