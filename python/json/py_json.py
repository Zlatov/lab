#!/usr/bin/env python
# -*- coding: utf-8 -*-
from __future__ import print_function
from termcolor import colored
import json

# with open('data.json') as f:
#   data = json.load(f)

# pprint(data)


print(colored('> В словарь', 'green'))
a = """
{
  "a": 1
}
"""
b = json.loads(a)
print('a:', a)
print('b:', b)
print('b["a"]:', b["a"])
# exit(0)
