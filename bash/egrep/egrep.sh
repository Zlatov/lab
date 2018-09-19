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
