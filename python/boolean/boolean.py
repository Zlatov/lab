# -*- coding: utf-8 -*-
from termcolor import colored

print(colored('Данный тип является подтипом целого (int):', 'green'))
print(isinstance(True, int))  # True
print(isinstance(False, int))  # True
print(issubclass(bool, int))  # True

print(colored('Приведение других типов к True', 'green'))
a = True;
print(a)
a = bool(10);
print(a)
a = bool('some');
print(a)
a = bool('0');
print(a)

print(colored('Приведение других типов к False', 'green'))
a = False;
print(a)
a = bool(0);
print(a)
a = bool('');
print(a)
a = bool(None);
print(a)
a = bool();
print(a)

print(colored('Булевы операторы', 'green'))
a = bool(None) and True or True or False
print(a)
a =  not False or True
print(a)
a = not bool(None) and True or not True or False
print(a)
