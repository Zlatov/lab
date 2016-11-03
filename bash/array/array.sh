#!/bin/bash
array=(aaa bbb ccc)
echo $array                   # aaa
echo ${array[@]}              # aaa bbb ccc
echo ${array[1]}              # bbb
echo ${array[10]}             # пустая строка
echo "some text: ${array[1]}" # some text: bbb
array[11]=`echo "${array[1]} и ${array[2]}"`
echo ${array[11]}              # bbb и ссс
array[${#array[*]}]="последний ("

# Добавить элемент. (переиндексация)
array123=( "${array[@]}" "новый элемент" )

declare -a array2
declare -a array6=( "${array[@]#*ccc}" )
declare -a array7=( ${array[@]#*ccc} )
declare -a array8=( "${array[@]/новый1/}" )
echo ${array2[@]}             # пустая строка

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
for index in "${!array8[@]}"
do
	printf '%d %s\n' "$index" "${array8[$index]}"
done

echo 
echo "123:"
echo 
for index in "${!array123[@]}"
do
	printf '%d %s\n' "$index" "${array123[$index]}"
done
