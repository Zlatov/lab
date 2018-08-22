exit 0


# Добавление субмодуля
# В корне проекта к которому добавляем выполнить:
git submodule add git@github.com:Zlatov/Zlader.git js/_libs/zlader
# появятся новые файлы: .gitmodules, submodule_name
# закомитить...


# Клонирование проекта с субмодулями
git clone http:... ./
git submodule init
git submodule update
# или
git clone --recursive https:...

# Клонирование субмодулей после клонирования проекта
git submodule update --init --recursive

# Обновление отдельного субмодуля
# перейти в его директорию и проверить наличие изменений:
cd js/_libs/zlader
git fetch
# И затем для обновления выполнить:
git merge

# Обновление всех субмодулей
git submodule update --recursive --remote
# или
git pull --recurse-submodules

# Удаление подмодуля
# 1. Удалить нужную секцию в файле .gitmodules. 
subl .gitmodules
# [submodule "submodule_name"]
# path = submodule_name 
# url = git://github.com/any_user_name/submodule_name.git
# 2. Зафиксировать изменения, выполнив:
git add .gitmodules
# 3. Удалить соответствующие модулю строки из .git/config.
subl .git/config
# [submodule "submodule_name"] 
# url = git://github.com/any_user_name/submodule_name.git
# 4. Удалить пути, созданные для подмодулей, из области индексирования:
git rm --cached PATH/TO/SUBMODULE
# 5. Удалить каталог подмодуля:
rm -rf .git/modules/submodule_name
# 6. Сделать коммит изменений.
# 7. Удалить ненужные файлы подмодулей:
rm -rf path/to/submodule_name
