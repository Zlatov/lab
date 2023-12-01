# -*- coding: utf-8 -*-
import re

# pyenv exec pip install termcolor
from termcolor import colored

# re.match(pattern, string)               — ищет в начале строки, первое совпадение.
# re.search(pattern, string)              — ищет не только в начале строки, первое совпадение.
# re.findall(pattern, string)             — возвращает список всех найденных совпадений.
# re.split(pattern, string, [maxsplit=0]) — разделяет строку по заданному шаблону [не более maxsplit раз].
# re.sub(pattern, repl, string)           — ищет в строке шаблон и заменяет на подстроку.
# re.compile(pattern, repl, string)       — собрать регулярное выражение в объект, для поисков.

# match
print(colored('match() — ищет в начале строки.', 'green'))
a = re.match(r'z', 'zxc')
print("a:", a)
if a != None:
  b = a.group(0)
  print(colored("выполнить .group(0) если найдно, для полученя того что найдено.", "blue"))
  print("b:", b)
c = True if a != None else False
print("c:", c)

a = re.match(r'x', 'zxc')
print("a:", a)
b = True if a != None else False
print("b:", b)
# exit(0)

# search
print(colored("search — ищет не только в начале строки.", "green"))
a = 'asd'
b = re.search(r'f', a)
print("a:", a)
print("b:", b)
# print(a.group(0) if a != None else False)
# exit(0)

a = "asd'3143'"
b = re.search(r"'\d+'", a).group()
print('a:', a)
print('b:', b)
# exit(0)

a = "asd'123'234"
b = re.search(r"\d+", a)#.group(0)
print('a:', a)
print('b:', b)
# exit(0)

# findall
print(colored("findall() — возвращает список всех найденных совпадений.", "green"))
a = 'asd zxc asf'
b = re.findall(r'as.', a)
print('a:', a)
print('b:', b)
# exit(0)

a = 'asd'
b = re.findall(r'f', a)
print('a:', a)
print('b:', b)
# exit(0)

a = "asd zxc asd"
b = re.findall(r"(.)s(.)", a)
print("a:", a)
print("b:", b)
# exit(0)

# split
print(colored('\nsplit()', 'green'))
result = re.split(r'y', 'Analytics')
print(result)

# sub
print(colored("\nsub()", 'green'))
result = re.sub(r'India', 'the World', 'AV is largest Analytics community of India')
print(result)

# compile
print(colored('\ncompile()', 'green'))
pattern = re.compile('AV')
result = pattern.findall('AV Analytics Vidhya AV')
print(result)
result2 = pattern.findall('AV is largest analytics community of India')
print(result2)

# finditer(), который возвращает список объектов типа 'результат поиска'. 
# Получая эти загадочные объекты вместо обычных строк (которые может вернуть, к примеру, метод findall), 
# мы получаем возможность не только ознакомиться с фактом что текст найден, 
# но и узнать где именно он найден — для этого у объекта типа 'результат поиска' 
# есть специально обученный метод span(), возвращающий точное положение найденного фрагмента в исходном тексте.
