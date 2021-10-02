#!/usr/bin/env bash

set -eu

SOMEVAR=''

if [[ -z ${SOMEVAR-} ]]
then
  echo "Переменная SOMEVAR не установлена." 1>&2;
  # exit 0
  echo exit 0
fi

# if [[ -z ${SOMEVAR-} ]]; then echo "Переменная SOMEVAR не установлена." 1>&2; exit 0; fi

# Возвращает true в случае заданной переменной.
function var_exist_with_name {
  VAR_VALUE="${!1-}"
  if [[ -n ${VAR_VALUE} ]]
  then
    echo 'true'
  fi
}

echo "Переменная PWD существует: $(var_exist_with_name 'PWD')"
