#!/usr/bin/env bash

# 
# Выполнить из консоли (не билдом сублайма).
# 

set -eu

cd "$(dirname "${0}")"

curl -T ~/.ssh/config https://webdav.yandex.ru/accesses/ssh/config --user Zlatov:"${YANDEX_PASSWORD}"
