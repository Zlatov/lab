#!/bin/bash

. "`dirname $BASH_SOURCE`/../bash/_lib/colorize"

CONFIG_FILEPATH="`dirname $BASH_SOURCE`/config.sh"

if [ ! -f $CONFIG_FILEPATH ]
	then
		echo -en $COLOR_RED
		echo -e "Нет файла config.sh!"
		echo -en $STYLE_DEFAULT
		exit 0
	else
		. $CONFIG_FILEPATH
fi

export MYSQL_PWD="$DBPASS"
