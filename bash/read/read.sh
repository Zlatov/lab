#!/bin/bash
set -eu

# 
# `read -n 1` - количество символов
# 

echo -n 'A: '; read A

echo "A: ${A}"

if [[ -z "$A" ]]
then
  echo 'Вы ничего не ввели.'
else
  echo 'Вы ввели:' $A
  echo "Вы ввели: ${A}"
fi

echo -n "Введите пароль: "
read -s PASSWORD
echo -e "\nПароль: ${PASSWORD} хаха."

echo -n 'read -s1 a:'; read -s -n 1 key
case "$key" in
  '<'|',') echo "<";;
  '>'|'.') echo ">";;
esac
echo $key
