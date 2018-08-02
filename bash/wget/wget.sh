exit 1

wget -r -l3 http://lab.local/bash
# позво-ляет рекурсивно переходить по ссылкам на три уровня

wget -c -U Mozilla www.website.com
# выдаёт себя за браузер Mozilla

wget -r -l1 -A.pdf --no-parent http://url-to-webpage-with-pdfs/
# следовать по одному уровню сайта и скачивать все найденные pdf-файлы.
# –no-parent не разрешает Wget переходить по ссылкам на уровень вверх
# Опция «-A» позволяет указать список расширений или шаблонов, разделённых запятыми. Для того, чтобы игнорировать файлы определённого типа, используйте «-R» вместо «-A».

wget -P /path/to/save http://example.com/file.zip
# скачивание файла file.zip в директорию /path/to/save

wget -c http://example.com/file.zip
# докачивание файла file.zip в случаи обрыва

wget -O arch.zip http://example.com/file.zip
скачивание файла file.zip и сохранение под именем arch.zip

wget -i files.txt
скачивание файлов из списка в files.txt

wget --tries=10 http://example.com/file.zip
количество попыток на скачивание

wget -Q5m -i http://example.com/
квота на максимальный размер скачанных файлов, квота действует только при рекурсивном скачивании (-r)

wget --save-cookies cookies.txt --post-data 'username=proft&password=1' http://example.com/auth.php
идентификация на сервере с сохранением кук для последующего доступа

wget --user-agent="Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/536.5 (KHTML, like Gecko) Chrome/19.0.1084.9 Safari/536.5" http://example.com/
указание User Agent

echo 'wget http://example.com/file.zip' | at 12:00
скачать http://example.com/file.zip в 12:00 в текущую директорию

wget ftp://example.com/dir/*.zip
скачивание всех файлов по шаблону

wget http://example.com/dir/file{1..10}.zip
# скачивание всех файлов по шаблону

wget -S http://example.com/
# вывод заголовков HTTP серверов и ответов FTP серверов

wget --spider -i urls.txt
# проверка ссылок в файле на доступность

wget -b http://example.com/file.zip
# скачивание файла в фоне, лог пишется в wget.log, wget.log.1 и т.д.

export http_proxy=http://proxy.com:3128/;wget http://example.com/file.zip
# скачивание файла *file.zip* через прокси

wget -m -w 2 http://example.com/
# зеркалирование сайта с сохранением абсолютных ссылок и ожиданием 2-х секунд между запросами

wget --limit-rate=200k http://example.com/file.zip
# ограничение скорости скачивания

wget -R bmp http://example.com/
# не скачивать bmp файлы

wget -A png,jpg http://example.com/
# скачивать только файлы png и jpg
