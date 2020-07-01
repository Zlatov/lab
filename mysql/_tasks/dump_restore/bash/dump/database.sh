#!/usr/bin/env bash

set -eu

if [[ -f ./config.sh ]]
then
	. ./config.sh
else
	echo "Не настроено соединение с БД, выполните: cp config-example.sh config.sh"
	exit 0
fi

DBDATE=`date +%Y-%m-%d-%H-%M-%S`
mkdir -p dumps
mysqldump -u$DBUSER -h$DBHOST -p$DBPASS $DBNAME --routines > ./dumps/$DBNAME-$DBDATE.sql
sed -ri 's/DEFINER=[^ ]* //i' ./dumps/$DBNAME-$DBDATE.sql
tar -czf ./dumps/$DBNAME-$DBDATE.tar.gz ./dumps/$DBNAME-$DBDATE.sql
