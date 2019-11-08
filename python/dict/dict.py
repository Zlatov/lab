# -*- coding: utf-8 -*-
from __future__ import print_function
from termcolor import colored

print(colored('Пустой словарь', 'green'))
a = {}
print('a:', a)
# exit(0)

print(colored('Наполненный словарь', 'green'))
a = {
  'a': None,
  'a': 1,
  'b': 'asd',
  "c": None
}
print('a:', a)
print('a[\'a\']:', a['a'])
print('a["a"]:', a["a"])
# exit(0)
