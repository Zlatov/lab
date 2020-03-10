# encoding: UTF-8
require 'rubygems'
require 'byebug'
require 'mini_magick'
require 'awesome_print'

# byebug

# Определяем метод, который принимает блок, результат блока в yield
def self.dsl
  p "var - #{yield}"
end

# Запускаем метод и передаём в него блок
dsl do
  "huy"
end

puts '-----------------------'

# То же, но с параметром
def self.ftp
  p "var - #{yield("2")}"
end

ftp do |param|
  "#{param} - huy"
end

# def self.ftp
#   ...
#   yield(1, 2)
#   ...
# end

# a = []
# b = nil
# a.ftp do |param, as|
#   # "#{param} - huy"
#   b = param
# end
# p b

puts '-----------------------'

# метод принимает один параметр, блок за параметр не считается, но тут блок именован
def self.mtp a, &block100
  p a
  if block_given?
    p "var - #{block100.call("2")}"
  end
end

mtp 100 do |param|
  "#{param} - huy"
end
mtp 200
# exit

puts '-----------------------'
puts 'Блок можно передавать по ссылке, как блок, и брать его елду. Или передавать как значение в переменной и колить его.'.green
def self.another default=nil
  if block_given?
    p "like do end #{yield('block like block')}"
    p default
  else
    p "like var #{default.call('block like var')}"
  end
end

def self.stp &block
  another 1, &block
  another block
  p "имея по ссылке, его можно всёравно колить: - #{block.call("2")}"
end

stp do |param|
  "#{param} - huy"
end
# exit

puts '-----------------------'

def self.another default=nil
  if block_given?
    p "like do end #{yield}"
  else
    p "like var #{default.call}"
  end
end

def self.jtp &block
  # another block
  # another 1, &block
  block.call 2, &(proc { "block2" })
end

jtp do |param, &block2|
  p "#{param} - huy - #{block2.call}"
end

puts '-----------------------'
puts 'Хранение и вызов лямбда функций в константе класса.'.green

MYCONST = {
  asd: 'asd',
  zxc: lambda{|x|
    "zxc #{x}"
  },
  qwe: ->(x){
    "qwe #{x}"
  }
}

def st k
  self.class::MYCONST[k].call(111)
end

puts st :zxc
puts st :qwe

puts '-----------------------'
puts 'В блоке список команд, выполнение команд в методе.'.green
def self.terminal
  if block_given?
    commands = yield.split "\n"
    commands.each do |command|
      begin 
        eval(command).inspect
      rescue => e
        puts e.to_s + "\n" + e.backtrace.join("\n")
      end
    end
  end
end

terminal do
  <<-RUBY
    print "a"
    puts "b"
    print "c"
    puts "d"
  RUBY
end

puts '-----------------------'
puts 'В блоке выполнение команд, список в инстансе метода (в методе).'.green

class Array
  def each_as_tree
    each do |e|
      yield(e)
    end
  end
end

<<-RUBY
  print "a"
  puts "b"
  print "c"
  puts "d"
RUBY
.split("\n")
.each_as_tree do |command|
  puts command
end

puts 'Возвращение блоком несколько параметров'.green

def block_several_params
  main_param, options = yield
  print 'main_param: '.red; puts main_param
  print 'options: '.red; p options
end

a = block_several_params do 'asd' end
a = block_several_params do ['asd'] end
a = block_several_params do ['asd', nil] end
a = block_several_params do ['asd', {}] end
a = block_several_params do ['asd', {asd: "zxc", qwe: 2}] end
a = block_several_params do ['asd', asd: "zxc", qwe: 2] end
