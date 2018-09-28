require "awesome_print"

module Mod
  @@var = 1
  def var
    @@var
  end
  def var= value
    @@var = value
  end
  def self.extended obj
    obj.class_eval do
      @@var2 = 1
      def self.var2
        @@var2
      end
      def self.var2= value
        @@var2 = value
      end
    end
  end
end

class Cl
  extend Mod
end

class Cl2
  extend Mod
end

puts 'При extend не получается расширить класс переменной класса:'.green

p Cl.var
p Cl2.var
puts 'Поменяются оба:'.blue
Cl.var = 2
p Cl.var
p Cl2.var

puts 'При extend с extended не получается расширить класс переменной класса:'.green

p Cl.var2
p Cl2.var2
puts 'Поменяются оба:'.blue
Cl.var2 = 2
p Cl.var2
p Cl2.var2

puts 'Побороть всех:'.green

module M
  def self.included obj
    obj.extend ClassMethods
    obj.var = 1
  end
  module ClassMethods
    def var= value
      @var = value
    end
    def var
      @var
    end
  end
end

class C
  include M
end

class C2
  include M
end

p C.var
p C2.var
puts 'Поменяются только у одного:'.blue
C.var = 2
p C.var
p C2.var
