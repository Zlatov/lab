#!/usr/bin/env python
# -*- coding: utf-8 -*-
from __future__ import print_function
from termcolor import colored
import os

print(colored('Путь к директории файла (dirname)', 'green'))
a = 'asd/zxc/qwe.py'
b = os.path.dirname(a)
print("a:", a)
print("b:", b)

print(colored('Сложение путей (join)', 'green'))
# если второй путь будет начинаться от корня (/....), тогда проигнорируется
# предыдущий путь:
a = '/qwe/asd zxc'
b = os.path.join(a, a)
print('a:', a)
print('b:', b)
# сама подставит отсутствующий слэш, но не продублирует если есть:
a = os.path.join('/as/d/asd', '../../111')
b = os.path.join('/as/d/asd/', '../../111')
print('a:', a)
print('b:', b)
