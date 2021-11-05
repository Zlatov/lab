# https://www.youtube.com/watch?v=Gon0MvppfF8
# pyenv exec python main.py

import sys
import eel

print('sys.version_info:', sys.version_info)

eel.init("web")

eel.start("main.html", size=(700, 700))
