#!/usr/bin/env bash
set -eu
cd `dirname "$0"`
sqlite3 -bail\
  -column\
  -header\
  -nullvalue ''\
  -csv\
  $HOME/projects/zenon/market/db/development.sqlite3 < $1

exit 0
  -line\
  -echo\
  -stats\
