# -*- coding: utf-8 -*-
from termcolor import colored

print(colored('Полный синтаксис if', 'green'))
if True:
  print(True)
elif True:
  print(True)
else:
  print(True)

print(colored('if и None', 'green'))
if None:
  print('None is not true.')
if None is not None:
  print('None is not None.')
if None is None:
  print('None Is None.')

print(colored('Булевы операции в if', 'green'))
if True & (False | True):
  print(True)

a = True if True else False
print("a:", a)
