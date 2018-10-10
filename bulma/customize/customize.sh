#!/usr/bin/env bash
set -eu

cd `dirname "$0"`

mkdir -p temp
rm -rf temp
mkdir -p temp

/usr/local/bin/sass --no-source-map customize.scss:temp/mystyles.css
# /usr/local/bin/sass --watch --no-source-map customize.scss:temp/mystyles.css
