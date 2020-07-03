#!/usr/bin/env bash

set -eu

if [[ -z ${1-} ]]
then
  echo "Не указан файл дампа." 1>&2
  exit 1
fi

if [[ ! -f $1 ]]
then
	echo "Нет файла дампа." 1>&2
	exit 1
fi

echo "Начата процедура sed."

sed -ri 's/DEFINER=[^ ]* //i' "$1"

echo "Done."
