#!/usr/bin/env bash

. ../_lib/echoc

function foo {
  echoc "Имя функции: ${FUNCNAME}" blue
  echoc "Количество переданных параметров : $#" green
  echo "Все параметры переданные функции: '$@'"
}

foo nixCraft
foo 1 2 3 4 5
foo "this" "is" "a" "test"

# How do I parse command line arguments in Bash?
# Method #1: Using bash without getopt[s]

function coffee {
  POSITIONAL=()
  while [[ $# -gt 0 ]]
  do
    key="$1"
    case $key in
      -g|--sugar)
      SUGAR="$2"
      shift # past argument
      shift # past value
      ;;
      -s|--stir)
      STIR="$2"
      shift # past argument
      shift # past value
      ;;
      -m|--milk)
      MILK="$2"
      shift # past argument
      shift # past value
      ;;
      --default)
      DEFAULT=YES
      shift # past argument
      ;;
      *)    # unknown option
      POSITIONAL+=("$1") # save it in an array for later
      shift # past argument
      ;;
    esac
  done
  set -- "${POSITIONAL[@]}" # restore positional parameters

  echo SUGAR   = "${SUGAR}"
  echo STIR    = "${STIR}"
  echo MILK    = "${MILK}"
  echo DEFAULT = "${DEFAULT}"

  echoc "Имя функции: ${FUNCNAME}" blue
  echoc "Количество переданных параметров : $#" green
  echo "Все параметры переданные функции: '$@'"
}

# Проверка
# coffee
# coffee -g 3 -s 10
# coffee -g 3 -s 10 покрепче

# Проверка на ошибочные опции
# coffee -d 3 -s 10 
# coffee -d -s 10
# Опции превращаются в параметры
