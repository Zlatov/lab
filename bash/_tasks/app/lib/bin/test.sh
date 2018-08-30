function app_test() {
  [[ -n ${DEVELOPMENT-} ]] && ${DEVELOPMENT-} && echoc "Имя функции: ${FUNCNAME}" blue
  [[ -n ${DEVELOPMENT-} ]] && ${DEVELOPMENT-} && echoc "Количество переданных параметров: $#" green
  [[ -n ${DEVELOPMENT-} ]] && ${DEVELOPMENT-} && echo "Все параметры переданные функции: '$@'"
  echoc "Ты хочешь затестить" green
  # echo ${APP_DOMAINS[@]}
  # exit 0
  if [[ $# -gt 0 ]]
  then
    domains=($@)
    for domain in "${domains[@]}"
    do
      echoc $domain green
    done
  else
    echoc "всё" green
  fi
}
