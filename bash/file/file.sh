#!/bin/bash

set -eu

cd $(dirname "$0")

. ../_lib/echoc

# Очищаем директорию для теста:
filename=$(basename -- "${BASH_SOURCE[0]}") # Имя текущего исполняемого файла.
test_dirname="${filename%.*}" # Имя тестовой директории - это имя текущего файла без расширения.
mkdir -p ./$test_dirname
# find . -type f -not -name array.sh -delete
# find . -type d -not -path . | xargs -I {} rm -rf {}
find ./$test_dirname -type f -delete
find ./$test_dirname -type d -not -path ./$test_dirname | xargs -I {} rm -rf {}
# exit 0

echo
echoc "Преобразование пути к файлу в путь, имя файла, расширение, имя без расширения." green
echo ${BASH_SOURCE[0]}
echo ${BASH_SOURCE[@]}
echo $(basename ${BASH_SOURCE[0]})
echo $(dirname ${BASH_SOURCE[0]})
filepath="/asd/-zxc.tar.gz"; echo '$filepath: ' $filepath
filename=$(basename -- "$filepath"); echo '$filename: ' $filename
# Расширение это символы после последней точки
extension="${filename##*.}"; echo '$extension: ' $extension
name="${filename%.*}"; echo '$name: ' $name
# Расширение это символы после первой точки
extension="${filename#*.}"; echo '$extension: ' $extension
name="${filename%%.*}"; echo '$name: ' $name


echo
echoc "Создание файла." green
if [[ ! -f "${test_dirname}/temp" ]]
then
	touch $test_dirname/temp
	FILE_REALPATH=$(realpath "${test_dirname}/temp")
	echo '$FILE_REALPATH: ' $FILE_REALPATH
fi

echo
echoc "Запись в файл." green
{
	echo 'записывается первая строчка'
	echo 'записывается вторая строчка'
	echo 'записывается третья строчка'
} > $test_dirname/temp_file.txt

# Смотри как удаляются табы в начале строк за счёт знака «минус»!
echoc "Перезапись (>)." blue
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
} > $test_dirname/temp_file2.txt

echoc "Очищается любое количество повторяющихся табов в начале строки." blue
echoc "Дозапись (>>)." blue
echo "$(cat \
	<<-EOF
	!@#$%^&*()-=/.,?><\';|":][}{
		записывается первая строчка
		 записывается вторая строчка
			записывается третья строчка
		 	 записывается третья строчка
		${PATH}
	EOF
)" >> $test_dirname/temp_file2.txt
# exit 0

echo
echoc "Контент файла temp:" green
echo -n 'asd' > $test_dirname/temp
echo $(cat ./$test_dirname/temp)

echo
echoc "Количество строк (скорее переносов) в файле (переносов действительно 0)" green
a=$(wc -l < $test_dirname/temp)
echo '$a: ' $a

echo
echoc "Данный код выполняется в файле и в строке номер:" green
echo "${BASH_SOURCE[0]}:${LINENO}"

echo
echoc "Очистить файл" green
> $test_dirname/temp             # создаст если нет
truncate -s 0 $test_dirname/temp # создаст если нет
echo -n "" > $test_dirname/temp  # создаст если нет

echo
echoc "Контент файла:" green
echo $(cat ./$test_dirname/temp)
