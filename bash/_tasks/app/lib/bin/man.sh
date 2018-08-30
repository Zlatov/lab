function app_man {
  [[ -n ${DEVELOPMENT-} ]] && ${DEVELOPMENT-} && echoc "Имя функции: ${FUNCNAME}" blue
  [[ -n ${DEVELOPMENT-} ]] && ${DEVELOPMENT-} && echoc "Количество переданных параметров: $#" green
  [[ -n ${DEVELOPMENT-} ]] && ${DEVELOPMENT-} && echo "Все параметры переданные функции: '$@'"
  man $app_path/../lib/bin/man/app
}
