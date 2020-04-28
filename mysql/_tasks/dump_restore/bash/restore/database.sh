#!/usr/bin/env bash

set -eu

if [[ -f ./temp_config.sh ]]
then
	. ./temp_config.sh
else
	echo "Не настроено соединение с БД, выполните: cp config-example.sh temp_config.sh"
	exit 0
fi

if [[ -z ${1-} ]]
then
  echo "Не указан файл дампа." 1>&2;
  exit 0
fi

if [[ ! -f $1 ]]
then
	echo "Нет файла дампа."
	exit 0
fi


mysql --database="$DBNAME" --user="$DBUSER" --password="$DBPASS" < "$1"

# mysql --one-database … # Восстановление из мультидампа.
# mysql --init-command="SET SESSION FOREIGN_KEY_CHECKS=0;" … # Отключить слежение за внешними ключами при импорте.
