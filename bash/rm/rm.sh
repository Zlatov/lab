#!/bin/bash

# -r — Обрабатывать все вложенные подкаталоги.
#      Данный ключ необходим, если удаляемый файл является каталогом, пусть даже пустым.
#      Если удаляемый файл не является каталогом, то ключ -r не влияет на команду rm.
# -i — выводить запрос на подтверждение каждой операции удаления.
# -f — не возвращать код ошибочного завершения, если ошибки были вызваны несуществующими файлами;
#      не запрашивать подтверждения операций.

rm -r ./* # рекурсивно удалить всё из папки (не удаляет скрытые файлы с точкой в начале имени)
rm -rf mydir # рекурсивно удалить без подтверждения и кода ошибочного завершения файл (или директорию) mydir.

ls -1 ./path/to/files | xargs -I {} rm ./path/to/files/{} # если _очень_ много файлов
ls -1A ./path/to/files | xargs -I {} rm -rf ./path/to/files/{} # в том числе скрытые
ls -1A -I .gitignore -I README.md ./path/to/files | xargs -I {} rm -rf ./path/to/files/{} # за исключением файлов