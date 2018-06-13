#!/bin/bash

temp_path='./temp'

if [[ ! -f temp ]]
then
	touch $temp_path
fi

a='a'

# echo $a > $temp_path
# echo -n $a > $temp_path # Записывает в файл без переноса
# echo $a >> $temp_path

# b=$(cat $temp_path) # Считывает без переноса (даже если он есть зараза)
b=$(< $temp_path) # Считывает без переноса (даже если он есть зараза)

echo $b

if [[ ! "$b" = '' ]]
then
	echo 'не пустая строка.'
else
	echo 'пустая строка.'
fi

if [[ "$b" = 'a' ]]
then
	echo 'Одна строка считалась с a.'
else
	echo 'Не одна строка считалась с a.'
fi

cat temp | while read line
do
  echo "a line: $line"
done
