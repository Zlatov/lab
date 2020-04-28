#!/usr/bin/env bash

set -eu

cd "$(dirname "${BASH_SOURCE[0]}")"

cd ../..

if [[ -z ${1-} ]]
then
  echo "Не указан файл дампа." 1>&2;
  exit 0
fi

if [[ ! -f $1 ]]
then
	echo "Нет файла дампа."
	exit 0
fi

sed -ri 's/DEFINER=[^ ]* //i' "$1"
