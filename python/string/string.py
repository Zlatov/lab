#!/usr/bin/env python
# -*- coding: utf-8 -*-
# ^^^^^^^^^^^^^^^^^^^^^ Позволим использовать UTF8 символы в выполняемом файле

# В версии 2 print это оператор а не функция,
# импортируем из 3 версии функцию принт для расширенных возможностей (end='')
from __future__ import print_function

from termcolor import colored

import sys
# sudo apt-get install python-pip
# sudo pip install termcolor

print(colored('hello ', 'red') + colored('world', 'green'))

print("Привет мир", end=' ')
print('Привет мир');
print('Привет' + 'мир');
print('asd')
print(1)
# exit(0)

print(colored('Длинна строки', 'green'))
a = 'asd'
# print(colored("a [", 'red'), type(a), colored("]: ", 'red'), a, sep='')
b = len(a)
print(colored('a: ', 'red'), a)
print("b [", type(b), "]: ", b)
# exit(0)

print(colored('[:] - подстрока', 'green'))
a='1234567890'

b=a[2:]; print(b) # > 34567890
b=a[-2:]; print(b) # > 90

print() # > "\n"
b=a[:3]; print(b) # 123
b=a[:-3]; print(b)

print()
b=a[2:4]; print(b) # индексы начало и конца с начала
b=a[2:-4]; print(b) # индекс конца с конца
b=a[-6:6]; print(b) # индекс начала с конца
b=a[-6:-2]; print(b) # индексы с конца

print(colored('Индекс последней подстроки в строке', 'green'))
a = '@import "../../images'
doubl_quote_index = a.rfind("\"")
singl_quote_index = a.rfind("'")
print('doubl_quote_index:', doubl_quote_index)
print('singl_quote_index:', singl_quote_index)
quote_index = max(singl_quote_index, doubl_quote_index)
print('quote_index:', quote_index)
# exit(0)

# From version 3.6+
# a = "a"
# b = f"aa{a}a"
# print(b)

# From version 3.6+
# a = "a"
# b = f"""
# as{a}d
# """
# print(b)


# # SYNTAX VERSION 2.6+ >>>>>>>>>>>>>>>>>

# print colored('Форматирование строки', 'green')
# a = 1
# b = "B {} b b b.".format(a)
# print colored('a [', 'red') + type(a).__name__ + colored(']:', 'red'), a
# print colored('b:', 'red'), b
# # exit(0)

# print colored('Строку в массив', 'green')
# a = "asd  \t   zxc"
# b = a.split()
# print colored('a:', 'red'), a
# print colored('b [', 'red') + type(b).__name__ + colored(']:', 'red'), b
# a = "asd  \t   zxc"
# b = a.split("\t")
# print colored('a:', 'red'), a
# print colored('b [', 'red') + type(b).__name__ + colored(']:', 'red'), b
# # exit(0)

# print colored('Многострочный текст', 'green')
# if True:
#   a = \
#   """1
#   2
#   3"""

# print colored('a [', 'red') + type(a).__name__ + colored(']:', 'red'), a
# # exit(0)

# print colored('Форматирование строки', 'green')
# a = "a"
# b = "b"
# c = "c {1:} c {0:} c".format(a,b)
# # print(colored("c [", 'red'), type(c) + colored("]: ", 'red'), c)
# print colored('c:', 'red'), c
# # exit(0)

# print colored('Форматирование многострочного текста', 'green')
# a = 1
# b = """
# b {} b
# """.format(a)
# # print(colored("b [", 'red'), type(b) + colored("]: ", 'red'), b)
# print colored('b:', 'red'), b
# # exit(0)
