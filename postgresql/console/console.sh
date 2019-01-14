#!/usr/bin/env bash

set -eu

exit 0

sudo service postgresql status
sudo service postgresql start
sudo service postgresql stop
sudo service postgresql restart

# 
# Пользователи Постгрес
# 
# перед `psql` идёт указание «рутового» пользователя по умолчанию для СУБД Постгрес: postgres
# 
sudo -u postgres psql -c "\du"

# 
# Бызы Данных
# 
sudo -u postgres psql -c "\l"
