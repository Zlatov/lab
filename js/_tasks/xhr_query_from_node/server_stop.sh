#!/usr/bin/env bash

# set -eux
set -eu

if [[ -f "./pid.file" ]]
then
	read pid < "./pid.file"
	kill -9 $pid
	rm ./pid.file
	echo "== Тестовый сервер остановлен"
else
	echo "== Не найден pid.file процесса"
fi
