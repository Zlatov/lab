#!/usr/bin/env bash

set -eu

cd "$(dirname "${0}")"

cd ../..

bundle exec ruby ./test_nested_array.rb
