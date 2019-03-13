#!/usr/bin/env bash

set -eu

if [[ -z ${SOMEVAR-} ]]
then
  echo "Переменная SOMEVAR не установлена." 1>&2;
  exit 0
fi

if [[ -z ${SOMEVAR-} ]] then; echo "Переменная SOMEVAR не установлена." 1>&2; exit 0; fi
