#!/bin/bash
set -eu

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
