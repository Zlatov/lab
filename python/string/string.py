# -*- coding: utf-8 -*-
from termcolor import colored
# sudo apt-get install python-pip
# sudo pip install termcolor

print(colored('hello', 'red'), colored('world', 'green'))

print("Привет мир")
print('Привет мир');
print('Привет' + 'мир');
print('asd')
print(1)

print(colored('Длинна строки', 'green'))
a = 'asd'
b = len(a)
print(colored('a:', 'red'), a)
print("b [", type(b), "]: ", b, sep='')
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

a = "a"
b = "b {} b b b.".format(a)
print(colored("a [", 'red'), type(a), colored("]: ", 'red'), a, sep='')
print(colored("b [", 'red'), type(b), colored("]: ", 'red'), b, sep='')

a = "a"
b = "b"
c = "c {1:} c {0:} c".format(a,b)
print(colored("c [", 'red'), type(c), colored("]: ", 'red'), c, sep='')

a = 1
b = """
b {} b
""".format(a)
print(colored("b [", 'red'), type(b), colored("]: ", 'red'), b, sep='')
