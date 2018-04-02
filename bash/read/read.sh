#!/bin/bash

echo -n 'A: '; read A

echo $A

if [ "$A" = '' ]
then
  echo 'Вы ничего не ввели.'
else
  echo 'Вы ввели:' $A
  echo "Вы ввели: ${A}"
fi
