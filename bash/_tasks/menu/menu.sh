#!/usr/bin/env bash

set -eu

cd "$(dirname "${0}")"

. ../../_lib/echoc

# Очищаем текущую директорию для теста:
find . -type f -not -name menu.sh -not -name menu -delete
find . -type d -not -path . | xargs -I {} rm -rf {}

# . ../../_lib/menu

function menu {
  local option options index current
  local key
  local pointer tabulator tab

  pointer="\e[32m> \e[0m"
  tabulator="  "
  mapfile -t options
  current=0
  key=""

  while :
  do
    # Запоминаем позицию курсора перед выводом опций для того, чтобы выводить
    # список опций со смещённым курсором с этого же места в следующий раз.
    tput clear >/dev/tty
    # tput sc >/dev/tty

    # Вывод заголовка если задан
    [[ -n ${1-} && ${1-} == '-h' && -n "${2-}" ]] && printf '%s\n' "$2" >/dev/tty

    # Вывод списка с курсором
    for index in "${!options[@]}"
    do
      option="${options[$index]}"
      tab=$( (( $index == $current )) && echo -n "${pointer}" || echo -n "${tabulator}" )
      echo -e "${tab}${option}" >/dev/tty
    done

    # Вывод подсказки
    echo "Используйте клавиши < > или стрелки для выбора." >/dev/tty

    # Ждём ответ пользователя
    read -s -n 1 key </dev/tty

    # Если был введён пустой символ (Enter)
    if [[ -z $key ]]
    then
      break
    # Если считан видимый символ
    else
      # Меняем текущий индекс опций если были нажаты соответствующие клавиши
      case "$key" in
        '<' | ',' | 'A' )
          (( $current > 0 )) && (( current -- ))
        ;;
        '>' | '.' | 'B' )
          (( $current < "${#options[@]}" - 1 )) && (( current ++ ))
        ;;
      esac
      # Возвращаемся к тому месту откуда печатали
      # tput rc >/dev/tty
    fi
  done
  echo -n "${options[$current]}"
}

# touch temp
# echo -e "первый\nвторой\nтретий" | tee temp >/dev/null

# options=$(echo -e "первый\nвторой\nтретий")
# # или
# options="первый
# второй
# третий"
# # или
# options=$(cat ./temp)

# echo "$options"
# exit 0

choise=$(menu <<< $(echo -e "первый\nвторой\nтретий"))
echo "choise: ${choise}"

choise=$(menu -h "выберите:" <<< $(echo -e "первый\nвторой\nтретий"))
echo "choise: ${choise}"

choise=$(echo -e "первый\nвторой\nтретий" | menu -h "выберите:")
echo "choise: ${choise}"
