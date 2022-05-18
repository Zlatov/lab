# Если надо байбажить то запускать: ruby module.rb

require "awesome_print"
require "active_support"
require "byebug"

# Важно!
# 
# Объекты в Ruby не хранят свои собственные методы в себе.
# Класс A хранит свои методы в синглто-классе (`A).
# Экземпляр класса a хранит свои методы в синглтон-классе экземпляра (`a).
module M
end
class A
  include M # добавит методы в A (получается добавит прямо в класс - а значит это методы экземпляра.)
  extend  M # добавит методы в `A (синглтон-класс - а значит это будут методы класса)
end
a = A.new
a.extend(M) # добавит методы в `a (синглтон-класс экземпляра - будут методы экземпляра)


module Entity

  def self.extended base
  end

  def self.included base
    puts 'included self:', self
    puts 'included base:', base
    # Стандартный подход: в модуле хранить методы и для экземпляра, для класса
    # хранить методы в подмодуле ClassMethods. При расширении экземпляра
    # (include Entity) производить расширение класса
    # (base.extend ClassMethods).
    base.extend ClassMethods
  end

  def this_is_instance_method
    puts self
  end

  module ClassMethods
    def this_is_class_method
      puts self
    end

    attr_accessor :class_variable
    def self.extended base
      # byebug
      puts 'extended self:', self
      puts 'extended base:', base
      base.class_eval do
        # byebug
        puts 'base.class_eval self:', self
        @class_variable = 'init value'
      end
    end
  end
end

class Cla
  include Entity
end

class Cla2
  include Entity
end

puts Cla.methods.include? :this_is_class_method
puts Cla.instance_methods.include? :this_is_instance_method

puts 'Как инициализировать переменную класса при включении модуля'.green
Cla.class_variable = 3
puts Cla.class_variable
puts Cla2.class_variable
# exit 0


puts 'Расширение с помощью ActiveSupport, инициализация переменной класса при включении модуля'.green
module Modul
  extend ActiveSupport::Concern
  
  included do |base|
    def custom_instance_method
    end
    attr_accessor :instance_var
  end

  # class_methods do
  #   # attr_accessor :param
  # end

  module ClassMethods
    def custom_class_method
    end
    def self.extended base
      base.class_eval do
        @param = 'init value for class variable'
      end
    end
    attr_accessor :param
  end
end

class Genom
  include Modul
end
class Genom2
  include Modul
end
Genom.param = 3
puts Genom.param
puts Genom2.param
puts Genom2.instance_methods.include? :custom_instance_method
puts Genom2.methods.include? :custom_class_method
a = Genom.new
a.instance_var = 333
print 'a.instance_var: '.red; puts a.instance_var
# exit 0


puts 'Расширить экземпляр класса методом из модуля'.green
class Point
end
a = Point.new
module Origin
  def origin!
    @x = @y = 0
  end
end
a.extend Origin
puts a.methods.include? :origin!
class Point
  include Origin
end
a = Point.new
puts a.methods.include? :origin!


puts 'Расширить экземпляр класса через синглтон-класс экземпляра'.green
class Car; end
bmw = Car.new
class << bmw # мы внутри синглтон-класса объекта bmw
  def number
    'abc'
  end
end
# тоже самое, что и...
def bmw.number
  'abc'
end
puts bmw.number #=> 'abc'
