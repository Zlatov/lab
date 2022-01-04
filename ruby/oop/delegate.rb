require 'awesome_print'
require 'active_support/all'
# require 'active_support/core_ext/module/delegation'

# Класс на который мы хотим делегировать метод (uid)
class User
  # class << self
  #   attr_accessor :uid
  # end
  # или:
  cattr_accessor :uid
end

puts 'Устанавливаем переменнаю класса User (@@uid):'.green
User.uid = 100
puts User.uid

# Класс, который делегирует метод uid на объект сохранённый в переменной класса @@user
class Post
  cattr_accessor :user

  def self.init
    # Рубокоп ругается и предлагает использовать переменную инстанса, намекая на
    # то что с переменными класса какая-то проблема. Я хочу смоделировать эту
    # проблему чтобы понять её.
    @@user = User
  end

  class << self
    # attr_accessor :user
    delegate :uid, to: :user
  end
end

puts 'В .user пока нет User:'.green
puts Post.user

puts 'Теперь Post.user содержит User:'.green
# Post.user = User
Post.init
puts Post.user

puts 'А метод Post.uid делегируется на Post.user:'.green
puts Post.uid





puts 'Моделируем проблему с использованием переменных класса.'.green

puts 'Когда мы используем "классичесике" переменные класса:'
class A
  @@var = 10
  cattr_accessor :var
end
class Aa < A
end
puts Aa.var, '— дочерний класс унаследовал методы и значение переменной.'
Aa.var = 20
puts A.var, '— но переменная родительского класса была неявно изменена (плохо)!'

puts 'Когда мы используем переменные экземпляра класса:'
class B
  @test = 10
  class << self
    attr_accessor :test
  end
end
class Bb < B
end
puts Bb.test, '— дочерний класс унаследовал методы, но не значение переменной (тоже плохо)!'
Bb.test = 20
puts B.test, '— изменение в дочернем классе не приводят к изменению в родительском.'
