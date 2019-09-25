#!/usr/bin/env bash

set -eu

cd $(dirname "$0")

. ../_lib/echoc

# Директория для теста:
test_dir_name=grep_file_contents
mkdir -p ./$test_dir_name
find ./$test_dir_name -type f -delete
find ./$test_dir_name -type d -not -path ./$test_dir_name | xargs -I {} rm -rf {}

touch ./$test_dir_name/temp_1.css
touch ./$test_dir_name/temp_2.js
touch ./$test_dir_name/temp_3.css
echo "$(cat \
	<<-EOF
		asd
		zxc
		qwe
	EOF
)" >> ./$test_dir_name/temp_1.css
echo "$(cat \
	<<-EOF
		qwe
	EOF
)" >> ./$test_dir_name/temp_2.js
echo "$(cat \
	<<-EOF
		asd
	EOF
)" >> ./$test_dir_name/temp_3.css

echoc 'ищем asd' green
find -type f -name "*.css" | xargs grep "asd"
echoc 'только имена файлов' green
find -type f -name "*.css" | xargs grep -l "asd"
echoc 'ищем asd или zxc' green
find -type f -name "*.css" | xargs grep -E 'asd|zxc'
echoc 'показываем только найденное, если не нашли - не выкидывать ошибку' green
find -type f -name "*.css" | xargs grep -Eoh 'sd|xc' || true

# -h, --no-filename
# -H, --with-filename

# реальный пример ради которого писался файл:
find ./ -type f -name "*.css" | xargs grep -hoE 'url\(/market/.*\)' || true

# 
# `.`
# Соответствует любому отдельному символу.
# 
# `?`
# Предыдущий элемент не является обязательным и будет сопоставлен не более одного раза.
# 
# `*`
# Предыдущий элемент будет соответствовать ноль или более раз.
# 
# `+`
# Предыдущий элемент будет найден один или несколько раз.
# 
# `{N}`
# Предыдущий элемент соответствует ровно N раз.
# 
# `{N,}`
# Предыдущий элемент соответствует N или более раз.
# 
# `{N,M}`
# Предыдущий элемент сопоставляется не менее N раз, но не более M раз.
# 
# `-`
# Представляет диапазон, если он не является первым или последним в списке или конечной точкой диапазона в списке.
# 
# `^`
# Соответствует пустой строке в начале строки; также представляет символы, не входящие в список.
# 
# `$`
# Соответствует пустой строке в конце строки.
# 
# `\b`
# Соответствует пустой строке на краю слова.
# 
# `\B`
# Соответствует пустой строке, если она не на краю слова.
# 
# `\<`
# Сопоставьте пустую строку в начале слова.
# 
# `\>`
# Сопоставьте пустую строку в конце слова.
# 
