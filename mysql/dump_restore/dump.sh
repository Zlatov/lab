DBHOST=localhost
DBNAME=dbname
DBUSER=dbuser
DBPASS=dbpass
DBDATE=`date +%Y-%m-%d-%H-%M-%S`
mkdir -p dump
mysqldump --opt -u$DBUSER -h$DBHOST -p$DBPASS $DBNAME --routines > ./dump/$DBNAME-$DBDATE.sql
tar -czf ./dump/$DBNAME-$DBDATE.tar.gz ./dump/$DBNAME-$DBDATE.sql
