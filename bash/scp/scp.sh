#!/usr/bin/env bash
set -eu

cd $(dirname "$0")

. ../_lib/echoc

# Очищаем директорию для теста:
filename=$(basename -- "${BASH_SOURCE[0]}") # Имя текущего исполняемого файла.
test_dirname="${filename%.*}" # Имя тестовой директории - это имя текущего файла без расширения.
mkdir -p ./$test_dirname
find ./$test_dirname -type f -delete
find ./$test_dirname -type d -not -path ./$test_dirname | xargs -I {} rm -rf {}
# exit 0

echo
echoc "Команды на сервер." green
ssh local pwd
ssh local 'set -eu; cd ~; pwd'
ssh local	"$(cat \
	<<-EOF
		set -eu
		cd ~
		mkdir -p temp
		cd temp
		pwd
	EOF
)"

echo
echoc 'Копирование файла с переименованием и с "подставой"' green
ssh local '
	set -eu
	[[ -d temp ]] && rm -rf temp || echo "temp not exists"
	mkdir temp
	touch temp/temp_f
	mkdir -p temp/temp_d
	touch temp/temp_d/temp_f2
'
mkdir -p $test_dirname/temp_f_copy2
scp local:~/temp/temp_f $test_dirname/temp_f_copy  # создаст с новым именеи
scp local:~/temp/temp_f $test_dirname/temp_f_copy2 # положит в папку
echoc 'Выход: указать имя файла с помощью mv -T' blue
scp local:~/temp/temp_f $test_dirname && mv -T $test_dirname/temp_f $test_dirname/temp_f_copy3

echo
echoc 'Рекурсивное копирование папки' green
mkdir -p $test_dirname/temp_dest
scp -r local:~/temp $test_dirname/temp_dest

echo
echoc 'Рекурсивное копирование содержимого папки' green
mkdir $test_dirname/temp_dest2
scp -r local:~/temp/* $test_dirname/temp_dest2

echo
echoc "Скачать первые N папок." green
echoc 'scp -r server:/path_1 ~/path_2 … ./destination_path' blue
# Создадим на сервере папки
ssh local	"$(cat \
	<<-'EOF'
		set -eu
		cd ~
		[[ -d "temp" ]] && rm -rf temp || true
		mkdir -p temp
		a=($(seq 0 1 99))
		for v in "${a[@]}"
		do
			mkdir -p temp/temp_${v}
		done
		mkdir -p temp/temp_0/temp_a
		mkdir -p temp/temp_1/temp_b
		mkdir -p temp/temp_2/temp_c
		cd temp
		pwd
	EOF
)"
echoc 'Список имён директорий с сервера.' blue
a=($(ssh local 'set -eu; cd temp; find . -type d ! -path . -maxdepth 1 | head -5 | sed -r s/^.{2}//'))
echo "${a[@]}"
echoc 'Массив первых N элементов в директории на сервере.' blue
b=($(ssh local 'set -eu; cd temp; find $(pwd) -type d ! -path $(pwd) -maxdepth 1 | head -5'))
echo "${b[@]}"
mkdir -p $test_dirname/scp_first_n_folders
echoc 'Если массив не пуст - скачиваем.' blue
[[ "${#a[@]}" > 0 ]] && scp -r local:"${b[@]}" $test_dirname/scp_first_n_folders || true
# exit 0
