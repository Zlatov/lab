#!/usr/bin/env python
# -*- coding: utf-8 -*-
from __future__ import print_function
from termcolor import colored
import os

a = 'asd/zxc/qwe.py'
b = os.path.dirname(a)
print("a:", a)
print("b:", b)

a = 'qwe/asd zxc'
b = os.path.join(a)
c = os.path.join('/as/d/asd', '../../111')
print('a:', a)
print('b:', b)
print('c:', c)
