# -*- coding: utf-8 -*-

# 
# http://pythonicway.com/python-conditionals
# 

# import sys
# print sys.getdefaultencoding()

print("Привет мир")
a = True
b = a
if a:
	print a
print 'as'
print 0
a = 1

class bcolors:
	HEADER = '\033[95m'
	OKBLUE = '\033[94m'
	OKGREEN = '\033[32m'
	WARNING = '\033[93m'
	FAIL = '\033[91m'
	ENDC = '\033[0m'
	BOLD = '\033[1m'
	UNDERLINE = '\033[4m'

class Colorize:
	red = 'reddd'
	HEADER = '\033[95m'
	OKBLUE = '\033[94m'
	OKGREEN = '\033[32m'
	WARNING = '\033[93m'
	FAIL = '\033[91m'
	ENDC = '\033[0m'
	BOLD = '\033[1m'
	UNDERLINE = '\033[4m'
	def red():
		return 'red'

if a is b:
	print 'a is b'
else:
	print '\033[31ma not is b\033[0m'
print 'finish'

print Colorize.red


