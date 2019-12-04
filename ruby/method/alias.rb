# encoding: UTF-8
require 'rubygems'
require 'awesome_print'

class MyClass

  def asd
    'asd content'
  end
  alias :alias_asd :asd # alias - конструкция языка руби (нет запятой)
  alias_method :alias_asd, :asd # метод

  def self.zxc
    'zxc content'
  end
  class <<self
    alias :alias_zxc :zxc # чтобы заалиасить метод класса нужно `class <<self`
    alias_method :alias_zxc, :zxc
  end  
end

print 'asd: '.red; puts MyClass.new.asd
print 'alias_asd: '.red; puts MyClass.new.alias_asd

print 'zxc: '.red; puts MyClass.zxc
print 'alias_zxc: '.red; puts MyClass.alias_zxc


exit

class MyClass
end

MyClass.instance_eval {alias c class}
puts MyClass.new.c # undefined method `c' for # (NoMethodError)

MyClass.instance_eval {alias_method :cl, :class}
puts MyClass.new.cl#=> MyClass

#Оппа! alias не работает в контексте объекта, а alias_method работает!

MyClass.class_eval {alias c class}
puts MyClass.new.c #=> MyClass

MyClass.class_eval {alias_method :cls, :class}
puts MyClass.new.cls #=> MyClass
