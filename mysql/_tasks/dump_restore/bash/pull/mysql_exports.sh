#!/usr/bin/env bash

set -eu

cd "$(dirname "${BASH_SOURCE[0]}")"

. ../_lib/ssh.sh

if [[ -d ../export/mysql/exports ]]
then
	echo "Директория для дампов существует."
else
	mkdir -p ../export/mysql/exports
	echo "Создана директория для дампов."
fi

scp "${REMOTE_SERVER}":"${REMOTE_PATH}/bash/export/mysql/exports/*" ../export/mysql/exports

echo "Done."
