# encoding: UTF-8
require 'rubygems'
require 'awesome_print'

class Cl
  CONST = '1'
  print 'self.CONST: '.red; puts self::CONST
  def self.c
    CONST
  end
end

a = Cl::CONST
print 'a: '.red; puts a

a = Cl.c
print 'a: '.red; puts a
