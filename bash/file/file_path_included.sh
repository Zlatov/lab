#!/usr/bin/env bash

echoc 'Включённый файл выполняет функцию:' green
paths

echoc 'Включённый файл выводит данные:' green
  echo '--------------'
  for i in ${!BASH_SOURCE[@]}
  do
    echo $i ' : ' ${BASH_SOURCE[$i]}
  done
  echo `pwd`
  echo ":${LINENO}"
  echo '--------------'
