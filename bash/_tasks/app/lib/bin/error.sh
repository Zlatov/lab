function app_error {
  [[ -n ${DEVELOPMENT-} ]] && ${DEVELOPMENT-} && echoc "Имя функции: ${FUNCNAME}" blue
  [[ -n ${DEVELOPMENT-} ]] && ${DEVELOPMENT-} && echoc "Количество переданных параметров: $#" green
  [[ -n ${DEVELOPMENT-} ]] && ${DEVELOPMENT-} && echo "Все параметры переданные функции: '$@'"
  echoc "Ошибка." red
  echo "неизвестная команада. „${1}“"
  exit 1
}
