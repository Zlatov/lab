#!/usr/bin/env bash

set -eu

cd $(dirname "$0")

. ../_lib/echoc

function paths {
  echo '--------------'
  for i in ${!BASH_SOURCE[@]}
  do
    echo $i ' : ' ${BASH_SOURCE[$i]}
  done
  echo `pwd`
  echo ":${LINENO}"
  echo '--------------'
}

echoc 'Запускаемый файл выполняет функцию:' green
paths

echoc 'Запускаемый файл выводит данные:' green
  echo '--------------'
  for i in ${!BASH_SOURCE[@]}
  do
    echo $i ' : ' ${BASH_SOURCE[$i]}
  done
  echo `pwd`
  echo ":${LINENO}"
  echo '--------------'

. ./file_path_included.sh
