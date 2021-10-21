# -*- coding: utf-8 -*-
from termcolor import colored

print(colored('Задание списка', 'green'))
a = [1, 2, 3]
print('a type: ' + type(a).__name__)
print('a:', a)
print(colored('a [' + type(a).__name__ + ']:', 'red'), a)
# exit(0)

# Python List append()  Add Single Element to The List
# Python List extend()  Add Elements of a List to Another List
# Python List insert()  Inserts Element to The List
# Python List remove()  Removes Element from the List
# Python List index() returns smallest index of element in list
# Python List count() returns occurrences of element in a list
# Python List pop() Removes Element at Given Index
# Python List reverse() Reverses a List
# Python List sort()  sorts elements of a list
# Python List copy()  Returns Shallow Copy of a List
# Python List clear() Removes all Items from the List
# Python any()  Checks if any Element of an Iterable is True
# Python all()  returns true when all elements in iterable is true
# Python ascii()  Returns String Containing Printable Representation
# Python bool() Coverts a Value to Boolean
# Python enumerate()  Returns an Enumerate Object
# Python filter() constructs iterator from elements which are true
# Python iter() returns iterator for an object
# Python list() Function  creates list in Python
# Python len()  Returns Length of an Object
# Python max()  returns largest element
# Python min()  returns smallest element
# Python map()  Applies Function and Returns a List
# Python reversed() returns reversed iterator of a sequence
# Python slice()  creates a slice object specified by range()
# Python sorted() returns sorted list from a given iterable
# Python sum()  Add items of an Iterable
# Python zip()  Returns an Iterator of Tuples

print(colored('Массив в переменные', 'green'))
a = [1, 2, 3, 1]
b = a.count(1)
c = len(a)
d = a[0]
e, f, g, h = a
# print("b [", type(b), "]: ", b, sep='')
# print("c [", type(c), "]: ", c, sep='')
# print("d [", type(d), "]: ", d, sep='')
# print("e, f, g, h, i: ", e, f, g, h, sep=' ')
print(colored('a:', 'red'), a)
print(colored('b:', 'red'), b)
print(colored('c:', 'red'), c)
print(colored('d:', 'red'), d)
print(colored('e, f, g, h:', 'red'), e, f, g, h)
# exit(0)

print(colored('Массив имеет различные значения (max != min)', 'green'))
a = [1, 1, 1, 1, 2]
b = (max(a) == min(a))
print(colored('a:', 'red'), a)
print(colored('b:', 'red'), b)
# exit(0)

print(colored('Перебор многомерного массива', 'green'))
a = [[1, 2], [3, 4], [5, 6]]
print(colored('a:', 'red'), a)
i = 0
j = 0
for row in a:
  i+= 1
  for x in row:
    j+= 1
    print("[{}, {}] = {}".format(i, j, x))
# exit(0)

print(colored('Массив в строку', 'green'))
a = ['1', '2', '3']
b = ''.join(a)
print(colored('a:', 'red'), a)
print(colored('b:', 'red'), b)
a = [1, 2, 3]
b = ', '.join("-" + str(e) for e in a)
print(colored('a:', 'red'), a)
print(colored('b:', 'red'), b)
# exit(0)

print(colored('Преобразование элементов массива', 'green'))
a = [1, 2, 3]
b = [str(e) for e in a]
print(colored('a:', 'red'), a)
print(colored('b:', 'red'), b)
# exit(0)

print(colored('Вставка в начало массива', 'green'))
a = [1, 2, 3]
a.insert(0, '1')
print('a:', a)
print(colored('Вставка в конец массива', 'green'))
a = [1, 2, 3]
a.append('4')
print('a:', a)
# exit(0)
