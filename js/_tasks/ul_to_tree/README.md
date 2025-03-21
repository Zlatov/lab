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
```
