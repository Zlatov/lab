function app_deploy {
  [[ -n ${DEVELOPMENT-} ]] && ${DEVELOPMENT-} && echoc "Имя функции: ${FUNCNAME}" blue
  [[ -n ${DEVELOPMENT-} ]] && ${DEVELOPMENT-} && echoc "Количество переданных параметров: $#" green
  [[ -n ${DEVELOPMENT-} ]] && ${DEVELOPMENT-} && echo "Все параметры переданные функции: '$@'"
  echoc "Ты хочешь задиплоить." green
}
