# PyQt

PyQt — это привязка Python с открытым исходным кодом для виджет-инструментария Qt, который также функционирует как кросс-платформенная среда разработки приложений.

## Установка

```bash
pip3 install PyQt5 # выдаёт ошибку
# pip3 install --upgrade pip
pip3 install pyqt5==5.14.0 # предыдущая версия
# Проверить версию
pip list | grep PyQt
# Утилита pyuic5 должна ругаться в консоли на отсутствие ui-файла
pyuic5
# Установим Qt Desiger
sudo apt-get install qttools5-dev-tools
# Утилита для преобразования в бинарник
pip install pyinstaller
```
