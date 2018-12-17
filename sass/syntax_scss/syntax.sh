#!/usr/bin/env bash

set -eu

/usr/local/bin/sass "syntax.scss" "temp_syntax.css"
# Или в сублайм сбилдить `ctrl+shift+b -> SCSS`
