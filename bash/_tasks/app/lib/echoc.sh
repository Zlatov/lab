# Подключение
# . ../_lib/echoc
# Использование
# echoc 'Привет мир' 'green'

# Объявления hash-подобного массива:
declare -A ECHOC_COLORS
ECHOC_COLORS=(
  ['style_default']='\033[0m'

  ['red']='\033[31m'
  ['green']='\033[32m'
  ['blue']='\033[36m'
  ['yellow']='\033[33m'

  ['bold']='\033[1m'
)

function echoc {

  # OLD_CD=$(pwd)
  # cd $(dirname $BASH_SOURCE)
  # . colorize
  # cd $OLD_CD

  echo -en ${ECHOC_COLORS[$2]}
  echo -e $1
  echo -en ${ECHOC_COLORS[style_default]}
}