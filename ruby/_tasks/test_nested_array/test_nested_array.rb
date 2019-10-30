#!/usr/bin/env ruby

require 'active_support/all'
require 'awesome_print'
require 'nested_array'

print 'NestedArray: '.red; puts NestedArray

a = [
  {id: 1, pid: nil},
  {id: 2, pid: 1},
  {id: 3, pid: nil},
]

a = NestedArray::Array.new a

b = a.to_nested parent_id: :pid

print 'b: '.red; p b
