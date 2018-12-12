#!/usr/bin/env bash

set -eu

cd "$(dirname "${0}")"

# Очищаем текущую директорию для теста:
find . -type f -not -name tar.sh -delete
find . -type d -not -path . | xargs -I {} rm -rf {}
