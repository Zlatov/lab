# -*- coding: utf-8 -*-

key = None
choices = {'a': 1, 'b': 2}
result = choices.get(key, 'default')
print result

a = {
	1:2,
	2:3,
}[2]
print a

a = {
	1:2,
	2:3
}.get(3, None)
print a

a = 2
print False if a != 3 and a != 4 else True

if False:
	print 1
elif False:
	print 0
else:
	print None
