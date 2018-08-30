# -*- coding: utf-8 -*-
from termcolor import colored

# Numbers
# String
# List
# Tuple
# Dictionary

a = 1
b = type(a)
c = str(b)
print(colored("a [", 'red'), type(a), colored("]: ", 'red'), a, sep='')
print(colored("b [", 'red'), type(b), colored("]: ", 'red'), b, sep='')
print(colored("c [", 'red'), type(c), colored("]: ", 'red'), c, sep='')
print("a","b")
print('a', 'b', 'c', sep='')
