#!/bin/bash

set -eu

temp_single_path='./temp_single'
temp_array_path='./temp_array'

[[ ! -f $temp_single_path ]] && touch $temp_single_path
[[ ! -f $temp_array_path ]] && touch $temp_array_path

> $temp_single_path
> $temp_array_path


# Переменные
a='val'
b=("asd" "zxc qwe")

# Зписываем
echo $a > $temp_single_path
for v in "${b[@]}"
do
  echo $v >> $temp_array_path
done

# Считываем
# b=$(cat $path) # Считывает без переноса (даже если он есть зараза)
# b=$(< $path)   # Считывает без переноса (даже если он есть зараза)
aa=$(< $temp_single_path)
declare -a bb
while read line
do
  bb+=("$line")
done < $temp_array_path

# Сравниваем
if [[ "${a}" = "${aa}" ]]
then
  echo 'Простая переменная считалась корректно.'
else
  echo 'Простая переменная считалась не корректно.'
fi

if [[ "${b[@]}" = "${bb[@]}" && "${#b[@]}" = "${#bb[@]}" ]]
then
  echo 'Массив считалась корректно.'
else
  echo 'Массив считалась не корректно.'
fi

for value in "${bb[@]}"
do
  echo $value
done
