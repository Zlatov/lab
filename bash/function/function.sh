#!/usr/bin/env bash

. ../_lib/echoc

# 
# Синтаксис, абсолютно равнозначны:
# function copyFiles {…}
# function copyFiles(){…}
# function copyFiles() {…}
# 

# Тест области видимости переменных с функией.
echoc "Тест области видимости переменных с функией." green
a=1
b=1
function foo {
  local a=2
  b=2
  echo 'Локальная переменная $a: ' $a
  echo 'Не локальная переменная $b: ' $b
}
echo '$a до вызова foo: ' $a
echo '$b до вызова foo: ' $b
foo asd zxc
echo '$a после вызова foo: ' $a
echo '$b после вызова foo: ' $b

# Доступные данные внутри функции.
# При передаче аргументов в кавычках `foo "$b"` параметр воспринимается как единый, даже с пробелами.
echoc "Доступные данные внутри функции." green
echoc 'Внимание. При передаче аргументов в кавычках `foo "$b"` параметр воспринимается как единый, даже с пробелами.' blue
function foo {
  echo "Имя функции: ${FUNCNAME}"
  echo "Количество переданных параметров : $#"
  echo "Все параметры переданные функции: '$@'"
  echo "Запрошенная команда для вызова скрипта: $0"
  echo "Перебор параметров:"
  i=0
  for one_argument # по умолчанию for var in $@
  do
    ((i++))
    echo -n $one_argument
    [[ ! $i -eq $# ]] && echo -n " | "
  done
  echo
}

a='someparam'
b='one param'
foo "this" is "a" 1 "test" $a $b
foo "this" is "a" 1 "test" $a "$b"
# exit 0

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
      shift # забываем аргумент
      shift # забываем значение аргумента
      ;;
      -s|--stir)
      STIR="$2"
      shift # забываем аргумент
      shift # забываем значение аргумента
      ;;
      -m|--milk)
      MILK="$2"
      shift # забываем аргумент
      shift # забываем значение аргумента
      ;;
      --default)
      DEFAULT=YES
      shift # забываем аргумент
      ;;
      --exit)
      EXIT=true
      shift # забываем аргумент
      ;;
      *)    # встретили неизвестную опцию
      POSITIONAL+=("$1") # сохраним опцию как аргумент
      shift # забываем аргумент
      ;;
    esac
  done
  # Если были переданы аргументы
  [[ ${#POSITIONAL[*]} -gt 0 ]] && \
  set -- "${POSITIONAL[@]}" # восстановим из временного массива аргументов

  echo SUGAR   = "${SUGAR}"
  echo STIR    = "${STIR}"
  echo MILK    = "${MILK}"
  echo DEFAULT = "${DEFAULT}"

  # Выход из функции
  [[ "${EXIT-}" == true ]] && return 0 || true

  echoc "Имя функции: ${FUNCNAME}" blue
  echoc "Количество переданных параметров: $#" green
  echo "Все параметры переданные функции: '$@'"
}


# Проверка
coffee
coffee -g 3 -s 10
coffee -g 3 -s 10 покрепче

# Проверка на ошибочные опции
coffee -d 3 -s 10 
coffee -d -s 10
coffee -d -s 10 --exit
# Т.о. ошибочные опции превращаются в параметры
# exit 0






# Ещё 2 способа:

# Bash Equals-Separated (e.g., --option=argument) (without getopt[s])
# Usage ./myscript.sh -e=conf -s=/etc -l=/usr/lib /etc/hosts

# for i in "$@"
# do
# case $i in
#     -e=*|--extension=*)
#     EXTENSION="${i#*=}"
#     shift # past argument=value
#     ;;
#     -s=*|--searchpath=*)
#     SEARCHPATH="${i#*=}"
#     shift # past argument=value
#     ;;
#     -l=*|--lib=*)
#     LIBPATH="${i#*=}"
#     shift # past argument=value
#     ;;
#     --default)
#     DEFAULT=YES
#     shift # past argument with no value
#     ;;
#     *)
#           # unknown option
#     ;;
# esac
# done
# echo "FILE EXTENSION  = ${EXTENSION}"
# echo "SEARCH PATH     = ${SEARCHPATH}"
# echo "LIBRARY PATH    = ${LIBPATH}"
# echo "Number files in SEARCH PATH with EXTENSION:" $(ls -1 "${SEARCHPATH}"/*."${EXTENSION}" | wc -l)
# if [[ -n $1 ]]; then
#     echo "Last line of file specified as non-opt/last argument:"
#     tail -1 $1
# fi

# To better understand ${i#*=} search for "Substring Removal" in this guide. It is functionally equivalent to `sed 's/[^=]*=//' <<< "$i"` which calls a needless subprocess or `echo "$i" | sed 's/[^=]*=//'` which calls two needless subprocesses.

# Method #2: Using bash with getopt[s]
# from: http://mywiki.wooledge.org/BashFAQ/035#getopts
# getopt(1) limitations (older, relatively-recent getopt versions):
# can't handle arguments that are empty strings
# can't handle arguments with embedded whitespace
# More recent getopt versions don't have these limitations.
# Additionally, the POSIX shell (and others) offer getopts which doesn't have these limitations. Here is a simplistic getopts example:

# # A POSIX variable
# OPTIND=1         # Reset in case getopts has been used previously in the shell.

# # Initialize our own variables:
# output_file=""
# verbose=0

# while getopts "h?vf:" opt; do
#     case "$opt" in
#     h|\?)
#         show_help
#         exit 0
#         ;;
#     v)  verbose=1
#         ;;
#     f)  output_file=$OPTARG
#         ;;
#     esac
# done

# shift $((OPTIND-1))

# [ "${1:-}" = "--" ] && shift

# echo "verbose=$verbose, output_file='$output_file', Leftovers: $@"

# # End of file

# The advantages of getopts are:
# It's more portable, and will work in other shells like dash.
# It can handle multiple single options like -vf filename in the typical Unix way, automatically.
# The disadvantage of getopts is that it can only handle short options (-h, not --help) without additional code.
# There is a getopts tutorial which explains what all of the syntax and variables mean. In bash, there is also help getopts, which might be informative.


# Передача массивов в функцию
echoc "Передача массивов в функцию" green
function take_two_array {
  local array count
  # while (( $# ))
  # do
  #   array=()
  #   count=$1
  #   shift
  #   while (( count-- > 0 ))
  #   do
  #     array+=("$1")
  #     shift
  #   done
  #   echo "${array[@]}"
  # done

  # Или

  array1=()
  count=$1
  shift
  while (( count-- > 0 ))
  do
    array1+=("$1")
    shift
  done
  echo "${array1[@]}"

  array2=()
  count=$1
  shift
  while (( count-- > 0 ))
  do
    array2+=("$1")
    shift
  done
  echo "${array2[@]}"

  return 0
}

declare -a a=('asd asd' zxc 1)
declare -a b=('zxc zxc' qwe 2 3)
take_two_array "${#a[@]}" "${a[@]}" "${#b[@]}" "${b[@]}"
