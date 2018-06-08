#!/bin/bash
echo день | sed s/день/ночь/
echo '.PNG' | sed s/'.PNG'/'.png'/

echo 'asd.PNG' | sed s/'.PNG'/'.png'/

echo '.PNG.PNG' | sed 's/\.PNG$/.png/'

echo '.png.PNG' | sed 's/.PNG/.png/'

touch temp
echo -e "a\na \`b\nA \`b\nb" > temp

sed -n '/^a/Ip' temp > temp2
#    ^      ^^
#    │      ││
#    │      │└ выводим на печать найденное ────────┐
#    │      └ регистронезависимо                   ├ используются вместе для нахождения
#    └ подавляем печать всех строк исходного файла ┘

sed -ir 's/^a `/c `_/i' temp2
#    ^^  ^      ^
#    ││  │      └ регистронезависимо
#    ││  └ заменяем
#    │└ используем расширенные регулярные выражения
#    └ изменяем исходный файл

# sed использует basic regular expressions или extended regular expressions (с опцией -r),
# никаких perl-совместимых (((
# например нет \d, используйте [0-9]
echo "foobar" | sed -r 's/foo(\w+)/\1 is found/'
echo "foo123" | sed -rn 's/foo([0-9]+)/\1 is found/p'
echo "123.asd" | sed -nr 's/([0-9]+.\w+)/\1 is found/p'
