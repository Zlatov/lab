function echoe {
  echo -en "\033[31m" >&2
  echo -e $1 >&2
  echo -en "\033[0m" >&2
}

# Выводит сообщения только в случае запуска app с параметром --detail
# @ [-n] [-e] message
function echod {
  local NOSLASHN POSITIONAL
  local options options_abbr index option_line
  options=(NOSLASHN ESCAPES)
  options_abbr=(n e)
  NOSLASHN=false
  ESCAPES=false # enable interpretation of backslash escapes
  while [[ $# -gt 0 ]]
  do
    key="$1"
    case $key in
      -n)
      NOSLASHN=true
      shift
      ;;
      -e)
      ESCAPES=true
      shift
      ;;
      *)
      POSITIONAL+=("$1")
      shift
      ;;
    esac
  done
  [[ ${#POSITIONAL[*]} -gt 0 ]] && \
  set -- "${POSITIONAL[@]}"

  local message
  [[ $# = 0 ]] && echoe "Ошибка: ${BASH_SOURCE[0]}:${LINENO}" && exit 1
  message="$1"
  if [[ "$O_DETAIL" = true ]]
  then
    echo -n "> "
    option_line=""
    if [[ "$NOSLASHN" = true || "$ESCAPES" = true ]]
    then
      option_line="-"
      for index in "${!options[@]}"
      do
        eval option=\$${options[$index]}
        [[ $option = true ]] && option_line+=${options_abbr[$index]}
      done
    fi
    echo $option_line "${message}"
  fi
}

# Возвращает абсолютный путь к приложению.
# @ domain
function get_domain_path {
  local path
  eval path=\$${1}_path
  echo $path
}

function get_domain_repo {
  [[ $# != 1 ]] && echoe "Ошибка: ${BASH_SOURCE[0]}:${LINENO}" && exit 1
  local repo
  eval repo=\$${1}_repo
  echo $repo
}

# @ path
function get_git_branch {
  [[ $# != 1 ]] && echoe "Ошибка: ${BASH_SOURCE[0]}:${LINENO}" && exit 1
  local path=$1 branch
  branch=$(cd "$path" && echo $(git symbolic-ref --short HEAD))
  echo $branch
}

# Возвращает 0/1 в любом репозитории имя ветки свободно
# @ path branch
function is_exist_branch {
  [[ $# != 2 ]] && echoe "Ошибка: ${BASH_SOURCE[0]}:${LINENO}" && exit 1
  local path=$1 branch=$2
  length=$(cd "$path" && git branch | grep -c " ${branch}$")
  [[ $length != 1 ]] && return 1 || return 0
}

# Возвращает код 0 кода в любом репозитории имя ветки свободно
# @ branch_name
function is_domains_no_branch {
  [[ $# != 1 ]] && echoe "Ошибка: ${BASH_SOURCE[0]}:${LINENO}" && exit 1
  local branch_name="$1"
  local domain path
  for domain in "${DOMAINS[@]}"
  do
    path=$(get_domain_path "$domain")
    if is_exist_branch "$path" "$branch_name"
    then
      return 1
    fi
  done
  return 0
}

# Возвращает абсолютный путь к приложению $domain в тесте с номером $test_id.
# @ test_id domain
function get_test_domain_path {
  [[ $# != 2 ]] && echoe "Ошибка: ${BASH_SOURCE[0]}:${LINENO}" && exit 1
  local test_id domain
  test_id=$1
  domain=$2
  echo "${APP_TESTS_PATH}/${test_id}/${domain}"
}

function get_free_port {
  for (( i = 3100; i < 3199; i++ )); do
    if ! is_port_busy $i
    then
      echo $i
      return 0
    fi
  done
  echoe "Не удалось найти свободный порт."
  return 1
}

function check_ssh_alias {
  if ! egrep "[\s]?Host market_test[\s]?$" ~/.ssh/config &> /dev/null
  then
    echoc "Нет ssh алиаса market_test." red
    yN "Создать алиас? [yes/NO]"
    if [[ $YN -eq 1 ]]
    then
      echo $'\n\nHost market_test\n  User deployer\n  Port 22\n  Hostname host2.newstar.ru' >> ~/.ssh/config
    else
      echoe "Выполнение прервано по требованию пользователя."
      exit 0
    fi
  fi
}

function is_port_busy {
  local count=$(lsof -i -P -n | grep -c ":${1}")
  [[ "$count" -gt 0 ]] && return 0
  return 1
}

function screen_find_or_create {
  if screen -list | grep -q "test_${1}"
  then
    echo 'Экран существует.'
  else
    echo 'Экран не существует, пытаемся создать.'
    screen -dmS stgn
    if screen -list | grep -q 'stgn'
    then
      echo 'Экран существует.'
    else
      echo 'Экран не существует.' >&2
      exit 1
    fi
  fi
}

# @ path
function get_realpath {
  echo "$(cd "$(dirname "$1")"; pwd)/$(basename "$1")"
}
