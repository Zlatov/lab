#!/usr/bin/env bash
set -eu

# /usr/local/bin/sass --style=compressed scss/style.scss:temp/style.css

sass --style=compressed scss/style.scss:temp/style.css
