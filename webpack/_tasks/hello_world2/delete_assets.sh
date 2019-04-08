#!/usr/bin/env bash

set -eu

cd "$(dirname "${0}")"

# rm -rf public/assets/*

find public -type f -not -name home.html -not -name about.html -delete
find public -type d -not -path public | xargs -I {} rm -rf {}
