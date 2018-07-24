# encoding: UTF-8
require 'rubygems'
require 'awesome_print'

class Cl
  CONST = '1'
  print 'self.CONST: '.red; puts self::CONST
end

a = Cl::CONST
print 'a: '.red; puts a
