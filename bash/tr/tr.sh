#!/usr/bin/env bash
set -eu

. ../_lib/echoc

# Траслировать через tr с удалением символов
echoc "Траслировать через tr с удалением символов" green
echo "asd zxc" | tr -d "s"

# Траслировать через tr с удалением переносов
echoc "Траслировать через tr с удалением переносов" green
count=$(egrep -c "^echo" tr.sh | tr -d "\n")
echo -n $count
