#!/usr/bin/env bash

set -eu

cd "$(dirname "${0}")"

. ../_lib/echoc

# Очищаем текущую директорию для теста:
find . -type f -not -name sed.sh -delete
find . -type d -not -path . | xargs -I {} rm -rf {}
# exit 0

# Замена подстроки в строке на другую строку
echo день | sed s/день/ночь/
echo +день+ | sed s/день/ночь/

# Это регистрозависимо и всёравно это регулярка
echoc "Это регистрозависимо и всёравно это регулярка" green
echo '.PNGуPNG' | sed s/'.PNG$'/'.png'/

echoc "Отфильтровать строки: регулярка поиска плюс подавление вывода" green
touch temp
echo -e "asd\nqwe \`zxc\nQWE \`zxc\nasd2" > temp
sed -n '/^qw/Ip' temp > temp_res
#    ^       ^^
#    │       ││
#    │       │└ выводим на печать найденное ───────┐
#    │       └ регистронезависимо                  ├ используются вместе для нахождения
#    └ подавляем печать всех строк исходного файла ┘

echoc "Заменить в строках: регулярка замены" green
touch temp_2
echo -e "asd\nqwe \`zxc\nQWE \`zxc\nasd2" > temp_2
sed -ibackup -r 's/^qwe `/qwe `_/i' temp_2
#    ^        ^  ^               ^
#    │        │  │               └ регистронезависимо
#    │        │  └ заменяем
#    │        └ используем расширенные регулярные выражения
#    └ изменяем исходный файл и создаём резервную копию с суфиксом

# sed использует basic regular expressions или extended regular expressions (с опцией -r),
# никаких perl-совместимых (((
# например нет \d, используйте [0-9]
echo "foobar" | sed -r 's/foo(\w+)/\1 is found/'
echo "foo123" | sed -rn 's/foo([0-9]+)/\1 is found/p'
echo "123.asd" | sed -nr 's/([0-9]+.\w+)/\1 is found/p'

echo 'Сохранить в переменную найденное по регулярке'
a=$(echo "asd market_assd asd zxc" | sed -nr 's/.*(market[a-zA-Z_]+).*/\1/p')
echo $a

echo 'Фильтруем проток по регулярке и выводим только найденное'
ls | sed -nr 's/^te(.*)/\1/p'
