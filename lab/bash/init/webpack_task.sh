#!/usr/bin/env bash

set -eu

lab_path=$(cd "$(dirname "${BASH_SOURCE[0]}")" && cd ../../.. && pwd)
init_path=$(pwd)

cd "$(dirname "${BASH_SOURCE[0]}")"

cd ../../..

. bash/_lib/yn
. bash/_lib/echoc

if [[ $init_path != "$lab_path"* ]]
then
	echoc "Директория инициализации вне лаборатории." red
	exit 0
fi

yN "Инициализировать webpack тут: ${init_path}? [yes/NO]"
if [[ $YN -eq 1 ]]
then
	echoc "Инициализация" yellow
	mkdir -p "${init_path}/bash/prepare"
	mkdir -p "${init_path}/javascript"
	cp -t "${init_path}/bash/prepare" "${lab_path}/webpack/_tasks/lab/bash/prepare/development.sh"
	cp -t "${init_path}/javascript" "${lab_path}/webpack/_tasks/lab/javascript/js.js"
	cp -t "${init_path}/javascript" "${lab_path}/webpack/_tasks/lab/javascript/sass.scss"
	cp -t "${init_path}" "${lab_path}/webpack/_tasks/lab/webpack.config.js"
	cd $init_path
	yarn add @babel/core -D #": "^7.6.4",
	yarn add @babel/plugin-transform-runtime -D #": "^7.6.2",
	yarn add @babel/preset-env -D #": "^7.6.3",
	yarn add babel-loader -D #": "^8.0.6",
	yarn add css-loader -D #": "^3.2.0",
	yarn add file-loader -D #": "^4.2.0",
	yarn add mini-css-extract-plugin -D #": "^0.8.0",
	yarn add node-sass -D #": "^4.12.0",
	yarn add postcss-loader -D #": "^3.0.0",
	yarn add sass-loader -D #": "^8.0.0",
	yarn add style-loader -D #": "^1.0.0",
	yarn add webpack -D #": "^4.41.1"
	cd -
else
	echoc "Прервано пользователем" blue
	exit 0
fi

echoc "Done." green
