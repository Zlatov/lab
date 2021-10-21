# -*- coding: utf-8 -*-
import sys

from termcolor import colored

print(colored('Мажорная версия python', 'green'))
a = sys.version_info[0]
print('a type: ' + type(a).__name__)
print('a:', a)
# exit(0)

print(colored('Версия python', 'green'))
print('{}.{}.{}'.format(*sys.version_info))
print('{}.{}.{}.{}.{}'.format(*sys.version_info))
print('sys.version_info:', sys.version_info)
# exit(0)
