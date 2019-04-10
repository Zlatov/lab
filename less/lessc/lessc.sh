#!/usr/bin/env bash

set -eu

cd "$(dirname "${0}")"

# sudo npm install -g less
# sudo npm install -g less-plugin-clean-css

# lessc lessc.less temp_styles.css
/usr/local/bin/lessc --clean-css="--s1 --advanced --compatibility=ie8" lessc.less temp_styles.css
