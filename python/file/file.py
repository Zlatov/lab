#!/usr/bin/env python
# -*- coding: utf-8 -*-
from __future__ import print_function
from termcolor import colored
import os


print(colored('Чтение', 'green'))
file = open('file/01.txt')
a = file.read()
print('a:', a)

print(colored('Создание файла', 'green'))
file = open('file/02.txt', 'w')
# exit(0)

print(colored('Удаление файла', 'green'))
os.remove('file/02.txt')
# exit(0)

print(colored('Проверка существования файла', 'green'))
a = 'file/01.txt'
b = 'file/02.txt'
if os.path.isfile(a):
  print(colored("{} существует".format(a), 'blue'))
else:
  print(colored("{} не существует".format(a), 'red'))
if os.path.isfile(b):
  print(colored("{} существует".format(b), 'blue'))
else:
  print(colored("{} не существует".format(b), 'red'))
# exit(0)
