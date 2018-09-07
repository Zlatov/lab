#!/usr/bin/env bash

. ../_lib/echoc


for i in ${!BASH_SOURCE[@]}
do
  echo $i ' : ' ${BASH_SOURCE[$i]}
done
echo `pwd`

echo '----------------'

paths
