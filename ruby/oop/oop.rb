require 'awesome_print'

class Lorem

  def initialize
    @a = 1
  end
end

a = Lorem.new
print 'a: '.red; puts a



# Различия синглтон, класс, инстанс

class Foo
  def an_instance_method  
    puts "I am an instance method"  
  end  
  def self.a_class_method  
    puts "I am a class method"  
  end  
end

foo = Foo.new

def foo.a_singleton_method
  puts "I am a singletone method"
end

foo = Foo.new

class << foo
  def a_singleton_method
    puts "I am a singleton method"
  end
end

class Foo
  class << self
    def a_singleton_and_class_method
      puts "I am a singleton method for self and a class method for Foo"
    end
  end
end

puts 'Удалить инстансный метод из класса'.green

foo.an_instance_method

puts 'remove_method - удаляет метод из класса, но вызывается у предка если было наследование.'.blue
class Foo
  remove_method :an_instance_method
end
# Или
# Foo.send(:remove_method, :an_instance_method)

foo = Foo.new

begin
  foo.an_instance_method
rescue => e
  puts e.message
end

puts 'undef_method - удаляет из класса и запрещает вызов из предка если было наследование.'.blue
class Foo
  def an_instance_method2
    puts 'Foo an_instance_method2'
  end
end
class Bar < Foo
  def an_instance_method2
    puts 'Bar an_instance_method2'
  end
end

bar = Bar.new

bar.an_instance_method2

Bar.send(:undef_method, :an_instance_method2)

bar = Bar.new

begin
  bar.an_instance_method2
rescue => e
  puts e.message
end
