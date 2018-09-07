#!/usr/bin/env bash

. ../_lib/echoc

function paths {
  for i in ${!BASH_SOURCE[@]}
  do
    echo $i ' : ' ${BASH_SOURCE[$i]}
  done
  echo `pwd`
}

paths

echo '--------------'

. ./file_path_included.sh
