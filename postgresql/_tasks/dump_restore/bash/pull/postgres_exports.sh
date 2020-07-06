#!/usr/bin/env bash

set -eu

cd "$(dirname "${BASH_SOURCE[0]}")"

. ../_lib/ssh.sh

if [[ -d ../export/postgres/exports ]]
then
	echo "Директория для дампов существует."
else
	mkdir -p ../export/postgres/exports
	echo "Создана директория для дампов."
fi

scp "${REMOTE_SERVER}":"${REMOTE_PATH}/bash/export/postgres/exports/*" ../export/postgres/exports

echo "Done."
