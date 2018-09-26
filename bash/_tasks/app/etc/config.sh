
errors_log_path=$(get_realpath $APP_PATH/../log/errors.log)

test_taken_names_path="${APP_PATH}/../var/test/taken_names.cache"
[[ ! -d $(dirname "$test_taken_names_path") ]] && mkdir -p $(dirname "$test_taken_names_path")
[[ ! -f "$test_taken_names_path" ]] && touch "$test_taken_names_path"
test_taken_names_path=$(get_realpath $APP_PATH/../var/test/taken_names.cache)

# Домены
DOMAINS=(
  admin
  framework
  market
)

# Пути доменные
market_path=$(cd "${APP_PATH}/../../../../market" && echo `pwd`)
admin_path=$(cd "${APP_PATH}/../../../../admin" && echo `pwd`)
framework_path=$(cd "${APP_PATH}/../../../../framework" && echo `pwd`)

# Репозитории доменные
market_repo='ssh://git@git2.newstar.ru:7999/ruby/market-990.git'
admin_repo='ssh://git@git2.newstar.ru:7999/ruby/admin.git'
framework_repo='ssh://git@git2.newstar.ru:7999/ruby/framework.git'

# Домены которые можно запустить как приложение
APP_DOMAINS=(admin market)
