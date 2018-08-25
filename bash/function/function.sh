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
  echoc "Количество переданных параметров: $#" green
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
