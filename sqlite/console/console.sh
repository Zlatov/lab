#!/usr/bin/env bash
exit 0

sqlite3 ./my_database.sqlite3 < ./task.sql
sqlite3 ./my_database.sqlite3 'SQL CODE;'
sqlite3 ./my_database.sqlite3 <<-'EOF'
	SQL CODE;
EOF
