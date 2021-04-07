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
