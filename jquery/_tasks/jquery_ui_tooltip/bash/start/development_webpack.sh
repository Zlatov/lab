#!/usr/bin/env bash

set -eu

cd "$(dirname "${BASH_SOURCE[0]}")"

cd ../..

yarn

rm -rf public/packs

npm run development
