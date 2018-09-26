function app_test {
  local domain deployable_domains running_domains
  local branch deployable_branches

  test_id=$(app_test_get_id)
  echo -n "Ваш идентификатор теста: "
  echoc "${test_id}" bold
  app_test_prepare_place "$test_id"

  deployable_domains=($(get_deployable_domains $@))
  deployable_branches=($(get_deployable_branches "${deployable_domains[@]}"))

  test_echo_deployable "${#deployable_domains[@]}" "${deployable_domains[@]}" \
    "${#deployable_branches[@]}" "${deployable_branches[@]}"

  running_domains=($(get_running_domains $@))
  test_echo_running "${running_domains[@]}"

  check_git_status "${deployable_domains[@]}"
  check_ssh_alias
  push "$test_id" "${#deployable_domains[@]}" "${deployable_domains[@]}" \
    "${#deployable_branches[@]}" "${deployable_branches[@]}"
  test_pull_git "$test_id" "${#deployable_domains[@]}" "${deployable_domains[@]}" \
    "${#deployable_branches[@]}" "${deployable_branches[@]}"
  test_pull_dataset "$test_id"
  start_test "$test_id" "${running_domains[@]}"
}

# Возвращает свободный идентификатор для теста
function app_test_get_id {
  if [[ -n "${O_TEST_ID}" ]]
  then
    echo "${O_TEST_ID}"
  else
    if [[ "$O_LOCAL" = true ]]
    then
      test_get_id_local
    else
      # TODO to remote
      app -l test_get_id
    fi
  fi
}

function test_get_id_local {
  local date_string number test_id
  date_string=$(date +%Y-%m-%d-%H-%M)
  number=false
  for (( i = 0; i < 1000; i++ ))
  do
    test_id="${date_string}-${i}"
    if is_test_no_take_name "$test_id" && is_domains_no_branch "$test_id"
    then
      number="$i"
      test_take_name "$test_id"
      break
    fi
  done
  if [[ $number = false ]]
  then
    echoe "Ошибка test_get_id_local."
    exit 1
  fi
  echo "$test_id"
}

# Проверяет были ли намерения взять имя для ветки (так как пуш не мгновенен,
# каждая попытка взять новое имя загоняется в кэш)
# @ branch_name
function is_test_no_take_name {
  [[ $# != 1 ]] && echoe "Ошибка количества параметров is_test_no_take_name." && exit 1
  local branch_name=$1
  while read line
  do
    if [[ "$line" = "$branch_name" ]]
    then
      return 1
    fi
  done < $test_taken_names_path
  return 0
}

# Запоминает намерение взять имя для тестовой ветки
# @ branch_name
function test_take_name {
  [[ $# != 1 ]] && echoe "Ошибка количества параметров test_take_name." && exit 1
  local branch_name=$1
  echo $branch_name >> $test_taken_names_path
}

function check_git_status {
  local domain is_has_modified is_has_staged is_has_untracked git_status
  git_status=true
  for domain
  do
    path=$(get_domain_path $domain)
    is_has_modified=$(cd "$path" && if [[ -n "$(git diff --exit-code)" ]]; then echo true; else echo false; fi)
    is_has_staged=$(cd "$path" && if [[ -n "$(git diff --cached --exit-code)" ]]; then echo true; else echo false; fi)
    is_has_untracked=$(cd "$path" && if [[ -n "$(git ls-files --other --exclude-standard)" ]]; then echo true; else echo false; fi)
    if [[ "$is_has_modified" = true ]]; then
      echoe "Нельзя отправлять, есть изменения в домене ${domain}."
      git_status=false
    fi
    if [[ "$is_has_staged" = true ]]; then
      echoe "Нельзя отправлять, есть незафиксированные изменения в домене ${domain}."
      git_status=false
    fi
    if [[ "$is_has_untracked" = true ]]; then
      echoe "Нельзя отправлять, есть неотслеживаемые файлы в домене ${domain}."
      git_status=false
    fi
  done
  if [[ "$git_status" = false ]]
  then
    exit 1
  fi
}

# Домены которые нужно затестить взяв их текущую ветку
# вычисляются из переданных пользователем доменов
# @ submited_domain@
function get_deployable_domains {
  local domain domains=()
  if [[ $# -gt 0 ]]; then
    for domain; do
      if is_included $domain "${DOMAINS[@]}"
      then
        domains+=("$domain")
      else
        echoe "Переданный домен не определён ${domain}."
        exit 1
      fi
    done
  else
    domains=("${DOMAINS[@]}")
  fi
  echo "${domains[@]}"
}

# Ветки доменов которые нужно затестить
# @ deployable_domains@
function get_deployable_branches {
  local domain branches=()
  for domain
  do
    path=$(get_domain_path $domain)
    branch=$(cd "$path" && echo $(git symbolic-ref --short HEAD))
    branches+=("$branch")
  done
  echo "${branches[@]}"
}

# Домены которые нужно запустить
# вычисляются из переданных пользователем доменов
# @ submited_domain@
function get_running_domains {
  local domain domains=()
  if [[ $# -gt 0 ]]; then
    for domain
    do
      # Если переданный домен есть апп-домен, то переданный домен в запускаемые
      if is_included $domain "${APP_DOMAINS[@]}"
      then
        domains+=("$domain")
      # Иначе все апп-домены в запускаемые
      else
        for app_domain in "${APP_DOMAINS[@]}"
        do
          if ! is_included $app_domain "${domains[@]-}"
          then
            domains+=("$app_domain")
          fi
        done
      fi
    done
  else
    domains=("${APP_DOMAINS[@]}")
  fi
  echo "${domains[@]}"
}

# @ test_id #deployable_domains@ deployable_domains@ #deployable_branches@ deployable_branches@
function push {
  local count deployable_domains deployable_branches
  local domain branch index status
  test_id="$1"
  shift
  deployable_domains=()
  count=$1
  shift
  while (( count-- > 0 ))
  do
    deployable_domains+=("$1")
    shift
  done

  deployable_branches=()
  count=$1
  shift
  while (( count-- > 0 ))
  do
    deployable_branches+=("$1")
    shift
  done

  for index in ${!deployable_domains[@]}
  do
    domain=${deployable_domains[$index]}
    branch=${deployable_branches[$index]}
    path=$(get_domain_path "$domain")
    echod -n "Домен ${domain}: заталкиваем гит ветку ${branch} через ${test_id}…"
    {
      if is_exist_branch "$path" "$test_id"
      then
        cd $path 2>>$errors_log_path >/dev/null && \
        git branch -D "$test_id" 2>>$errors_log_path >/dev/null && \
        git push origin --delete "$test_id" 2>>$errors_log_path >/dev/null
      fi
      cd $path 2>>$errors_log_path >/dev/null && \
      git checkout -b $test_id 2>>$errors_log_path >/dev/null && \
      git push origin $test_id 2>>$errors_log_path >/dev/null && \
      git checkout $branch 2>>$errors_log_path >/dev/null
    } && {
      echod -n -e "\r\033[0K"
      echod "Домен ${domain}: затолкнута гит ветка ${branch} через ${test_id}."
    } || {
      echo ""
      echoe "Ошибка."
      echo "Подробности в ${errors_log_path}"
      exit 1
    }
  done
}

# @ test_id #deployable_domains@ deployable_domains@ #deployable_branches@ deployable_branches@
function test_pull_git {
  local test_id deployable_domains deployable_branches
  local domain index branch
  test_id="${1}"
  shift
  deployable_domains=()
  count=$1
  shift
  while (( count-- > 0 ))
  do
    deployable_domains+=("$1")
    shift
  done
  deployable_branches=()
  count=$1
  shift
  while (( count-- > 0 ))
  do
    deployable_branches+=("$1")
    shift
  done

  for domain in "${DOMAINS[@]}"
  do
    if is_included "$domain" "${deployable_domains[@]}"
    then
      index=$(get_index "$domain" "${deployable_domains[@]}")
      branch=${deployable_branches[$index]}
    else
      branch="master"
    fi
    app_test_pull_domain "$test_id" "$domain" "$branch"
  done
}

# @ test_id domain branch
function app_test_pull_domain {
  local test_id domain branch
  [[ $# != 3 ]] && echoe "Ошибка" && exit 1
  test_id=$1
  domain=$2
  branch=$3
  if [[ "$O_LOCAL" = true ]]
  then
    test_pull_domain_local "$test_id" "$domain" "$branch"
  else
    # TODO to remote
    app -l test_pull_domain "$test_id" "$domain" "$branch"
  fi
}

# test_id domain branch
function test_pull_domain_local {
  local test_id domain branch
  [[ $# < 3 ]] && echoe "Неверное количество аргументов test_pull_local."
  test_id="$1"
  domain="$2"
  branch="$3"
  mkdir -p "${APP_TESTS_PATH}/${test_id}/${domain}"
  if ! is_test_domain_cloned "$test_id" "$domain"
  then
    test_clone_domain "$test_id" "$domain"
  fi
  test_checkout_branch "$test_id" "$domain" "$branch"
  return 0
}

# @ test_id domain domain domain
function start_test {
  local domain test_id
  test_id="${1}"
  shift
  for domain
  do
    app_test_start_domain "$test_id" "$domain"
  done
}

# @ test_id domain
function app_test_start_domain {
  local test_id domain
  [[ $# != 2 ]] && echoe "Ошибка количества параметров app_test_start_domain." && exit 1
  test_id="$1"
  domain="$2"
  if [[ "$O_LOCAL" = true ]]
  then
    test_start_domain_local "$test_id" "$domain"
  else
    # TODO to remote
    app -l test_start_domain "$test_id" "$domain"
  fi
}

# @ test_id domain
function test_start_domain_local {
  [[ $# != 2 ]] && echoe "Ошибка количества параметров test_start_domain_local." && exit 1
  local test_id="$1" domain="$2"
  local path port
  path=$(get_test_domain_path "$test_id" "$domain")
  port=$(get_free_port)
  prepare_screen "$test_id" "$domain"
  screen_name="${test_id}_${domain}"
  $APP_PATH/../lib/domain/$domain/start_test.sh "$screen_name" "$path" "$port"
  echo -n "Тест запущен для "
  echoc -n "${domain}" bold
  echo " по адресу http://localhost:${port}."
}

# @ test_id domain
function prepare_screen {
  local test_id domain
  [[ $# != 2 ]] && echoe "Ошибка количества параметров test_start_domain_local." && exit 1
  test_id="$1"
  domain="$2"
  if screen -list | grep -q "${test_id}_${domain}"
  then
    echod "Экран ${domain} для теста ${test_id} существует."
  else
    echod "Экран ${domain} для теста ${test_id} не существует, пытаемся создать."
    screen -dmS "${test_id}_${domain}"
    if screen -list | grep -q "${test_id}_${domain}"
    then
      echod "Экран ${domain} для теста ${test_id} существует."
    else
      echod "Экран ${domain} для теста ${test_id} не существует." >&2
      exit 1
    fi
  fi
  return 0
}

# @ test_id
function app_test_prepare_place {
  local test_id="$1"
  if [[ "$O_LOCAL" = true ]]
  then
    test_prepare_place_local "$test_id"
  else
    # TODO to remote
    app -l test_prepare_place "$test_id"
  fi
  return 0
}

# Создаёт путь к тесту, 
# @ test_id
function test_prepare_place_local {
  local test_id="${1}"
  [[ -z "${test_id}" ]] && echoe "Не определён идентификатор теста." && exit 1
  [[ -z "${APP_TESTS_PATH-}" ]] && echoe "Не определён в окружении путь к месту тестов." && exit 1
  [[ ! -d "${APP_TESTS_PATH}/${test_id}" ]] && mkdir -p "${APP_TESTS_PATH}/${test_id}"
  return 0
}

# @ #deployable_domains@ deployable_domains@ #deployable_branches@ deployable_branches@
function test_echo_deployable {
  local count deployable_domains deployable_branches
  local domain index
  deployable_domains=()
  count=$1
  shift
  while (( count-- > 0 ))
  do
    deployable_domains+=("$1")
    shift
  done

  deployable_branches=()
  count=$1
  shift
  while (( count-- > 0 ))
  do
    deployable_branches+=("$1")
    shift
  done

  if [[ "$O_YES" = false ]]
  then
    for domain in "${DOMAINS[@]}"
    do
      echo -n "Домен "
      echoc -n "${domain}" bold
      echo -n " на ветке "
      if is_included $domain "${deployable_domains[@]}"
      then
        index=$(get_index $domain "${deployable_domains[@]}")
        echoc "${deployable_branches[$index]}" yellow
      else
        echoc "master" bold
      fi
    done
  fi
}


# @ running_domains
function test_echo_running {
  local running_domains=($@)
  if [[ "$O_YES" = false ]]
  then
    echo -n "Запуск теста для:"
    [[ "${#running_domains[*]}" -gt 0 ]] && for domain in "${running_domains[@]}"
    do
      echo -n " "
      echoc -n "$domain" yellow
    done
    echo ""
    echo "================="

    if [[ "$O_YES" = false ]]
    then
      Yn "Продолжить? [YES/no]"
      if [[ ! $YN -eq 1 ]]
      then
        exit 0
      fi
    fi
  fi
}

# Проверка есть ли гит репозиторий в тест/домен
# @ test_id domain
function is_test_domain_cloned {
  local test_id domain
  [[ $# != 2 ]] && echoe "Неверное количество переданных аргументов" && exit 1
  test_id=$1
  domain=$2
  [ -d ${APP_TESTS_PATH}/${test_id}/${domain}/.git ] && return 0
  return 1
}

# @ test_id domain
function test_clone_domain {
  local test_id domain
  local repo path
  [[ $# != 2 ]] && echoe "Ошибка количества параметров test_clone_domain." && exit 1
  test_id=$1
  domain=$2
  repo=$(get_domain_repo $domain)
  path=$(get_test_domain_path $test_id $domain)
  echod -n "Домен ${domain}: клонируем репозиторий…"
  {
    $(cd $path && git clone $repo ./ 2>>$errors_log_path >/dev/null)
  } && {
    echod -n -e "\r\033[0K"
    echod "Домен ${domain}: репозиторий склонирован."
  } || {
    echo ""
    echoe "Ошибка."
  }
}

# @ test_id domain branch
function test_checkout_branch {
  local test_id domain branch
  [[ $# != 3 ]] && echoe "Ошибка количества параметров test_checkout_branch." && exit 1
  test_id=$1
  domain=$2
  branch=$3
  path=$(get_test_domain_path $test_id $domain)
  $(cd $path && git fetch)
  if is_exist_branch "$path" "$branch"
  then
    current_branch=$(get_git_branch $path)
    if [[ $current_branch != $branch ]]
    then
      echod -n "Домен ${domain}: переключаем гит на ветку $branch…"
      {
        $(cd $path && git checkout "$branch" 2>>$errors_log_path >/dev/null)
      } && {
        echod -n -e "\r\033[0K"
        echod "Домен ${domain}: гит переключен на ветку $branch."
      } || {
        echo ""
        echoe "Ошибка."
      }
    fi
  else
    echod -n "Домен ${domain}: переключаем гит на ветку $branch с созданием ветки…"
    {
      $(cd $path && git checkout -b "$branch" "origin/${branch}" 2>>$errors_log_path >/dev/null)
    } && {
      echod -n -e "\r\033[0K"
      echod "Домен ${domain}: гит переключен на ветку $branch с созданием ветки."
    } || {
      echo ""
      echoe "Ошибка."
    }
  fi
  return 0
}

# @ test_id
function test_pull_dataset {
  local test_id
  [[ $# != 1 ]] && echoe "Ошибка количества параметров test_pull_dataset." && exit 1
  test_id="$1"
  app_test_pull_db "$test_id"
  app_test_pull_constants "$test_id"
  app_test_pull_trees "$test_id"
  app_test_pull_required_items "$test_id"
  return 0
}

# @ test_id
function app_test_pull_db {
  local test_id
  [[ $# != 1 ]] && echoe "Ошибка количества параметров app_test_pull_db." && exit 1
  test_id=$1
  if [[ "$O_LOCAL" = true ]]
  then
    test_pull_db_local "$test_id"
  else
    # TODO to remote
    app -l test_pull_db "$test_id"
  fi
  return 0
}

# @ test_id
function test_pull_db_local {
  local test_id
  [[ $# != 1 ]] && echoe "Ошибка количества параметров test_pull_db_local." && exit 1
  test_id="$1"
  market_test_path=$(get_test_domain_path "$test_id" "market")
  echod -n 'Домен market: копируем базы данных…'
  cp ${market_path}/db/production.sqlite3 ${market_test_path}/db
  cp ${market_path}/db/development.sqlite3 ${market_test_path}/db
  echod -n -e "\r\033[0K"
  echod 'Домен market: скопированы базы данных.'
}

# @ test_id
function app_test_pull_trees {
  local test_id
  [[ $# != 1 ]] && echoe "Ошибка количества параметров app_test_pull_trees." && exit 1
  test_id="$1"
  if [[ "$O_LOCAL" = true ]]
  then
    test_pull_tree_local "$test_id"
  else
    # TODO to remote
    app -l test_pull_trees "$test_id"
  fi
  return 0
}

# @ test_id
function test_pull_tree_local {
  local test_id
  [[ $# != 1 ]] && echoe "Ошибка количества параметров test_pull_tree_local." && exit 1
  test_id="$1"
  admin_test_path=$(get_test_domain_path "$test_id" "admin")
  echod -n "Домен admin: копируем деревья…"
  mkdir -p ${admin_test_path}/db/fs
  cp -r ${admin_path}/db/fs/tree ${admin_test_path}/db/fs
  echod -n -e "\r\033[0K"
  echod "Домен admin: скопированы деревья."
  return 0
}

# @ test_id
function app_test_pull_required_items {
  local test_id
  [[ $# != 1 ]] && echoe "Ошибка количества параметров app_test_pull_required_items." && exit 1
  test_id="$1"
  if [[ "$O_LOCAL" = true ]]
  then
    test_pull_required_items_local "$test_id"
  else
    # TODO to remote
    app -l test_pull_required_items "$test_id"
  fi
  return 0
}

# @ test_id
function test_pull_required_items_local {
  local test_id
  [[ $# != 1 ]] && echoe "Ошибка количества параметров test_pull_required_items_local." && exit 1
  test_id="$1"
  admin_test_path=$(get_test_domain_path "$test_id" "admin")
  echod -n "Домен admin: копируем необходимые итемы…"
  mkdir -p ${admin_test_path}/db/fs/item/json
  cp -r ${admin_path}/db/fs/item/json/affiliate ${admin_test_path}/db/fs/item/json
  echod -n -e "\r\033[0K"
  echod "Домен admin: скопированы необходимые итемы."
  return 0
}

# @ test_id
function app_test_pull_constants {
  local test_id
  [[ $# != 1 ]] && echoe "Ошибка количества параметров app_test_pull_constants." && exit 1
  test_id="$1"
  if [[ "$O_LOCAL" = true ]]
  then
    test_pull_constants_local "$test_id"
  else
    # TODO to remote
    app -l test_pull_constants "$test_id"
  fi
  return 0
}

# @ test_id
function test_pull_constants_local {
  local test_id
  [[ $# != 1 ]] && echoe "Ошибка количества параметров test_pull_constants_local." && exit 1
  test_id="$1"
  market_test_path=$(get_test_domain_path "$test_id" "market")
  echod -n 'Домен market: копируем константы…'
  cp ${market_path}/config/cache/{metric.json,sale_statistic.json,trader.json,strict_color.json,CAT_production.dump,CAT_development.dump} ${market_test_path}/config/cache
  echod -n -e "\r\033[0K"
  echod 'Домен market: скопированы константы.'
  return 0
}
