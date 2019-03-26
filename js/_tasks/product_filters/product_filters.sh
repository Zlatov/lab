#!/usr/bin/env bash
set -eu

cd "$(dirname "${0}")"

# `sudo npm install uglify-es -g`

uglifyjs product_filters.js -o temp_product_filters.min.js --comments -c
uglifyjs filter.js -o temp_filter.min.js --comments -c
