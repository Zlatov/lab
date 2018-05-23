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
#    │      │└ выводим на печать найденное
#    │      └ регистронезависимо
#    └ подавляем печать всех строк исходного файла

sed -ir 's/^a `/c `_/i' temp2
#    ^^  ^      ^
#    ││  │      └ регистронезависимо
#    ││  └ заменяем
#    │└ используем расширенные регулярные выражения
#    └ изменяем исходный файл
