# Просмотр дисков, их объемов, и занимаемого пространства каталогов

```sh
# Все диски с точками монтирования, размером файловой системы и объёмами
# используемого/свободного пространтства.
df -h
df -h / # Только диска системы
df -ht ext4 # Только диски с типом ext4

# du (disk usage)
# Стандартная Unix программа для оценки занимаемого файлового пространства.
du -h                 # рекурсивно в текущей директории показать размеры всех папок (часто слишком большой вывод).
du -hs                # размер только текущего каталога (-s) и в удобной для человека форме (-h).
du -h -d 1            # размеры каталогов на глубину 1.
du -h -d 1 ./app      # размеры каталогов на глубину 1 в директории app.
du -scm Downloads doc # размеры только указанных каталогов (-s) и итоговый их размер (-c) в мегабайтах (-m).
```