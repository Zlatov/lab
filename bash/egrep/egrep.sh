#!/usr/bin/env bash
set -eu

cd `dirname "$0"`
. ../_lib/echoc

# Поиск строки в файле
echoc "Поиск строки в файле" green
touch temp && > temp && echo -e "asd\nzxc\nqwe" | tee -a temp >/dev/null

if egrep -qi "zxc" temp
then
  echo y
else
  echo n
fi

if egrep -qi "zxcc" temp
then
  echo y
else
  echo n
fi

{
  egrep -qi "zxc" temp
} && {
  echo y
} || {
  echo n
}

{
  egrep -qi "zxcc" temp
} && {
  echo y
} || {
  echo n
}

echoc 'Поиск фалов содержащих подстроки' green
egrep -lir "(zxcc|файле|zxc)" .
echoc 'Поиск фалов учитывая расширение' green
egrep -lir --include=*.{js,sh} "(zxcc|файле|zxc)" .
