# -*- coding: utf-8 -*-
from termcolor import colored

class Cl(object):
  def __init__(self, arg = None):
    super(Cl, self).__init__()
    self.arg = arg

a = Cl()
print(colored("a [", 'red'), type(a), colored("]: ", 'red'), a, sep='')
