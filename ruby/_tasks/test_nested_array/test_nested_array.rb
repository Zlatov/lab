#!/usr/bin/env ruby

require 'awesome_print'
require 'nested_array'

print 'NestedArray: '.red; puts NestedArray

a = [
  {id: 1, pid: nil},
  {id: 2, pid: 1},
  {id: 3, pid: nil},
]

b = a.to_nested

print 'b: '.red; p b
