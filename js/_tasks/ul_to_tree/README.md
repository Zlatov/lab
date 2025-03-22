```sh
rm -r ./css/* # Удаляем скомпилированные css файлы

node-sass --watch --recursive --output css --source-map true --source-map-contents sass
node-sass --watch sass/           --recursive --output css
node-sass --watch sass/index.scss --recursive --output css
node-sass --watch sass/index.scss             --output css
node-sass --watch sass/           --recursive --output css

node-sass --watch sass/ --recursive --output css
# Получилось, чтобы node-sass НЕ компилировал "подфайлы" файла index.scss, такие
# как ul_to_tree.scss, ul_to_tree2.scss в свои css файлы
# (css/ul_to_tree.css, css/ul_to_tree2.css), необходимо переименовать их,
# добавив в начало файла "_". Что является довольно неочевидным поведением
# программы.

# Переезжаемы на новый транспиляторо sass! Его бинарник можно установить как с
# npm, так и с ruby, но пишут что надо имеено npm, так как руби устарел. Но в
# руби есть гем sass-embedded который обходит устаривание ))) Если установить
# sass с помощью npm и удалить sass гем в ruby, то всёравно в консоли which
# sass будет указывать на бинарник руби, который не будет "находиться" и
# ругаться ошибкой. В общем, очень всё удобно и гибко!
sass sass/index.scss:css/index.css -w
```
