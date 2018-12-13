# -*- coding: utf-8 -*-
from termcolor import colored

a = [1, 2, 3]
print("a [", type(a), "]: ", a, sep='')

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

a = [1, 2, 3, 1]
b = a.count(1)
c = len(a)
d = a[0]
e, f, g, h = a
print("b [", type(b), "]: ", b, sep='')
print("c [", type(c), "]: ", c, sep='')
print("d [", type(d), "]: ", d, sep='')
print("e, f, g, h, i: ", e, f, g, h, sep=' ')

a = [1, 1, 1, 1, 2]
b = (max(a) == min(a))
# print(colored(a, "red"))
print("a:", a)
print("b:", b)

a = [[1, 1, 1, 1, 1], [1, 1, 1, 1, 1], [1, 1, 1, 1, 1], [1, 1, 1, 1, 1], [1, 1, 1, 1, 1]]
print("a:", a)

i = 0
j = 0
for x in a:
  i+= 1
  for y in x:
    j+= 1
    print("i:", i)
    print("j:", j)
    print("y:", y)
