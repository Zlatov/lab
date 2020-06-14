# Hello World в PyQt5

Файл _hw.ui_ создан в Qt Desiger, затем ипортирован в hw.py консольной утилитой:

```bash
pyuic5 path/to/design.ui -o output/path/to/design.py
```

Затем пишем код приложения в main.py

```bash
# И запускаем
python3 main.py
python main.py # Ошибка, тут может быть другая версия питона без модуля PyQt5
```

Создание бинарника

```bash
pip install pyinstaller
pyinstaller --onefile -w ./main.py
rm -rf ./build
rm main.spec
mv dist/main ./main
```
