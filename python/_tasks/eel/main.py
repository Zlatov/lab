# https://www.youtube.com/watch?v=Gon0MvppfF8
# еще одна статья для начинающих: https://habr.com/ru/post/550426/
# 
# Документация по eel:
# https://github.com/ChrisKnott/Eel
# 
# Запуск:
# pyenv exec python main.py
# 
# Сгенерировать исполняемый файл с помощью pyinstaller
# pyenv exec pip install pyinstaller
# pyenv exec pyinstaller main.py
# ...

# import sys
import eel

# print('sys.version_info:', sys.version_info)

eel.init("web")

eel.start("main.html", size=(700, 700), port=8001)
