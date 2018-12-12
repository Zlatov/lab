#!/usr/bin/env bash

set -eu

cd "$(dirname "${0}")"

# Очищаем текущую директорию для теста:
find . -type f -not -name pg_dump.sh -delete
find . -type d -not -path . | xargs -I {} rm -rf {}

# Дамипим
pg_dump --file=temp_1_no-owner.sql --dbname=lab --no-owner
pg_dump --file=temp_2_schema-only.sql --dbname=lab --schema-only
pg_dump --file=temp_3_lorem.sql --dbname=lab --table=lorem
pg_dump --file=temp_4_no-privileges.sql --dbname=lab --no-privileges
pg_dump --file=temp_5_inserts.sql --verbose --dbname=lab --inserts
pg_dump --file=temp_6_column-inserts.sql --dbname=lab --column-inserts

# Дамипим
pg_dump --file=temp_sql.sql --dbname=lab --no-owner
tar -czf temp_sql.sql.tar.gz temp_sql.sql
mkdir temp
tar -xf temp_sql.sql.tar.gz -C temp
# Дамипим
pg_dump --file=temp/temp_pg.pg --dbname=lab --no-owner --format=c

exit 0

Usage:
  pg_dump [OPTION]... [DBNAME]

General options:
  -f, --file=FILENAME          output file or directory name
  -F, --format=c|d|t|p         output file format (custom, directory, tar,
                               plain text (default))
  -j, --jobs=NUM               use this many parallel jobs to dump
  -v, --verbose                verbose mode
  -V, --version                output version information, then exit
  -Z, --compress=0-9           compression level for compressed formats
  --lock-wait-timeout=TIMEOUT  fail after waiting TIMEOUT for a table lock
  -?, --help                   show this help, then exit

Options controlling the output content:
  -a, --data-only              dump only the data, not the schema
  -b, --blobs                  include large objects in dump
  -c, --clean                  clean (drop) database objects before recreating
  -C, --create                 include commands to create database in dump
  -E, --encoding=ENCODING      dump the data in encoding ENCODING
  -n, --schema=SCHEMA          dump the named schema(s) only
  -N, --exclude-schema=SCHEMA  do NOT dump the named schema(s)
  -o, --oids                   include OIDs in dump
  -O, --no-owner               skip restoration of object ownership in
                               plain-text format
  -s, --schema-only            dump only the schema, no data
  -S, --superuser=NAME         superuser user name to use in plain-text format
  -t, --table=TABLE            dump the named table(s) only
  -T, --exclude-table=TABLE    do NOT dump the named table(s)
  -x, --no-privileges          do not dump privileges (grant/revoke)
  --binary-upgrade             for use by upgrade utilities only
  --column-inserts             dump data as INSERT commands with column names
  --disable-dollar-quoting     disable dollar quoting, use SQL standard quoting
  --disable-triggers           disable triggers during data-only restore
  --exclude-table-data=TABLE   do NOT dump data for the named table(s)
  --inserts                    dump data as INSERT commands, rather than COPY
  --no-security-labels         do not dump security label assignments
  --no-synchronized-snapshots  do not use synchronized snapshots in parallel jobs
  --no-tablespaces             do not dump tablespace assignments
  --no-unlogged-table-data     do not dump unlogged table data
  --quote-all-identifiers      quote all identifiers, even if not key words
  --section=SECTION            dump named section (pre-data, data, or post-data)
  --serializable-deferrable    wait until the dump can run without anomalies
  --use-set-session-authorization
                               use SET SESSION AUTHORIZATION commands instead of
                               ALTER OWNER commands to set ownership

Connection options:
  -d, --dbname=DBNAME      database to dump
  -h, --host=HOSTNAME      database server host or socket directory
  -p, --port=PORT          database server port number
  -U, --username=NAME      connect as specified database user
  -w, --no-password        never prompt for password
  -W, --password           force password prompt (should happen automatically)
  --role=ROLENAME          do SET ROLE before dump

If no database name is supplied, then the PGDATABASE environment
variable value is used.
