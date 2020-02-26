#!/usr/bin/env bash

set -eu

cd /home/iadfeshchm/projects/zenon/zenonline

RAILS_ENV=development bundle exec rails s
