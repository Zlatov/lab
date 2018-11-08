#!/usr/bin/env bash

set -eu

exit 0

sudo service postgresql status
sudo service postgresql start
sudo service postgresql stop
sudo service postgresql restart

# пользователи
sudo -u postgres psql -c "\du"

# бызы данных
sudo -u postgres psql -c "\l"
