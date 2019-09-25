#!/bin/bash

set -eu

cd $(dirname "$0")

# Очищаем текущую директорию для теста:
find . -type f -not -name file.sh -not -name file_path.sh -not -name file_path_included.sh -not -name csplit.sh -not -name split.sh -delete
find . -type d -not -path . | xargs -I {} rm -rf {}
# exit 0

. ../_lib/echoc

if [[ ! -f temp ]]
then
	touch temp
fi

echoc "Запись в файл." green
{
	echo 'записывается первая строчка'
	echo 'записывается вторая строчка'
	echo 'записывается третья строчка'
} > temp_file.txt

# Смотри как удаляются табы в начале строк за счёт знака «минус»!
{
	echo "$(cat \
		<<-EOF
		!@#$%^&*()-=/.,?><\';|":][}{
			записывается первая строчка
			 записывается вторая строчка
				записывается третья строчка
			 	 записывается третья строчка
			${PATH}
		EOF
	)"
} > temp_file2.txt

echoc "Очищается любое количество повторяющихся табов в начале строки." blue
echo "$(cat \
	<<-EOF
	!@#$%^&*()-=/.,?><\';|":][}{
		записывается первая строчка
		 записывается вторая строчка
			записывается третья строчка
		 	 записывается третья строчка
		${PATH}
	EOF
)" >> temp_file2.txt
exit 0

echo -n 'asd' > temp
echoc "Контент файла temp:" green
echo $(cat ./temp)

echoc "Количество строк (скорее переносов) в файле (переносов действительно 0)" green
a=$(wc -l < temp)
echo '$a: ' $a

echoc "Данный код выполняется в файле и в строке номер:" green
echo "${BASH_SOURCE[0]}:${LINENO}"

echoc "Очистить файл" green
> temp             # создаст если нет
truncate -s 0 temp # создаст если нет
echo -n "" > temp  # создаст если нет

echoc "Контент файла:" green
echo $(cat ./temp)
