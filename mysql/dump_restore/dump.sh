#!/usr/bin/env bash

set -eu

if [[ -f ./temp_config.sh ]]
then
	. ./temp_config.sh
else
	echo "Не настроено соединение с БД, выполните: cp config-example.sh temp_config.sh"
	exit 0
fi

DBDATE=`date +%Y-%m-%d-%H-%M-%S`
rm -rf temp
mkdir -p temp
mysqldump -u$DBUSER -h$DBHOST -p$DBPASS $DBNAME --routines > ./temp/$DBNAME-$DBDATE.sql
sed -ri 's/DEFINER=[^ ]* //i' ./temp/$DBNAME-$DBDATE.sql
tar -czf ./temp/$DBNAME-$DBDATE.tar.gz ./temp/$DBNAME-$DBDATE.sql
