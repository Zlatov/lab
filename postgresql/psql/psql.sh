#!/usr/bin/env bash

set -eu

PGPASSWORD=lab psql -U lab -c "\c lab"
PGPASSWORD=lab psql -U lab -c "CREATE DATABASE lab2 IF ;"
PGPASSWORD=lab psql -U lab -c "\c lab2"
