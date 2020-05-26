#!/usr/bin/env bash

set -eu

cd "$(dirname "${BASH_SOURCE[0]}")"

BASHHELP="
Для тестирования новой bash библиотеки «bashhelp».

Например \`echo hi\`
"
. ../_lib/bashhelp
. ../_lib/echoc

cd ../..

echo $(pwd)
echoc Done. green
