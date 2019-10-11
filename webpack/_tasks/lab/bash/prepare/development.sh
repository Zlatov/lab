#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE[0]}")"
cd ../..

rm -rf temp_public

./bin/webpack
