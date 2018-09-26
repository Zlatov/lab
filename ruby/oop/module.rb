require "rubygems"
require "awesome_print"
require "active_support"


=begin

при стандартном расширении

file1:

require_relative "file2"
class MyApp
  include Command
end

file2:

require_relative "file3"
module Command
  include Test
end

file3:
module Command
module Test

  def app_test
    say 'test'
  end
end
end

=end


module Entity

  # Плохой способ расширения класса:
  # def reinitialize
  #   self.class_eval '@@class_variable = ")"'
  # end

  # Автоматически запускает при `extend Entity`
  # но ужасный синтаксис внутри
  def self.extended obj
    puts '> extended'.green
    # obj.class_eval '@@class_variable = ")"'
    obj.class_eval do
      @@class_variable = ")!"
    end
  end

  # Фокус в том, что если поставить = nil (инициализировать),
  # то в методе `def self.class_var` будут использоваться атрибут МОДУЛЯ!!!
  # ЛУЧШЕ ТАК НЕ ДЕЛАТЬ:
  # @@class_var = 1

  # Автоматически запускает при `include Entity`
  def self.included obj
    puts '> included'.green
    obj.class_eval do
      # В любом мать его случае получается Атрибут МОДУЛЯ!!!
      @@class_var = 'clvar'
      def self.class_var
        @@class_var
      end
      attr_reader :array
      def initialize
        @array = ['asd']
      end
    end
    # obj.instance_eval "@array = [1,2,3]"
    # obj.instance_exec do
    #   @array = [1,2,3]
    # end
    # obj.class_eval "attr_reader :array"
  end

end

# Расширение с помощью ActiveSupport:

module Modul
  # Всегда include!
  extend ActiveSupport::Concern
  
  included do |base|
    # Как в классе!
    after_save :meth1
    def self.class_meth
    end
    def inst_meth
    end
    # Однако:
    class_eval do
      @@param
    end
  end

  def instance_method
  end

  class_methods do
    def method_name
      
    end
  end

  # То же самое:

  # При include
  module ClassMethods
    @@asd
    def class_method
      
    end
  end
end


class Cl

  # Просто включаем для расширения класса:
  extend Entity
  # Или
  # если нет `def self.extended` то принудительно:
  # reinitialize

  include Entity

  def self.show_uninitialized_class_variable
    puts @@class_variable
  end

  attr_accessor :asd
  cattr_accessor :asd

end

Cl.show_uninitialized_class_variable
p Cl.asd
p Cl.class_var
a = Cl.new
p a.array
p a.asd
