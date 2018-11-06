#!/usr/bin/env bash

set -eu

cd `dirname "$0"`

function menu {
  # echo "Количество переданных параметров: $#"
  # echo "Все параметры переданные функции: '$@'"
  local key option options index current pointer tabulator tab
  pointer="\e[32m> \e[0m"
  tabulator="  "
  options=($@)
  current=0
  key=""

  while :
  do
    tput sc >/dev/tty
    for index in "${!options[@]}"
    do
      option="${options[$index]}"
      tab=$( (( $index == $current )) && echo -n "${pointer}" || echo -n "${tabulator}" )
      echo -e "${tab}${option}" >/dev/tty
    done
    echo "Используйте клавиши < > для выбора." >/dev/tty
    read -s -n 1 key
    tput rc >/dev/tty
    case "$key" in
      '<'|',' )
        (( $current > 0 )) && (( current -- ))
      ;;
      '>'|'.' )
        (( $current < "${#options[@]}" - 1 )) && (( current ++ ))
      ;;
    esac
    if [[ -z $key ]]
    then
      for (( i = 0; i < "${#options[@]}" + 1; i++ )); do
        echo "" >/dev/tty
      done
      echo -n "${options[$current]}"
      break
    fi
  done
}

declare -a options=$(echo -e "qwe\nasd\nzxc")
choise=$(menu "$options")

echo "choise: ${choise}"
