#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE[0]}")"
cd ../..

rm -rf temp_public

./node_modules/webpack/bin/webpack.js
