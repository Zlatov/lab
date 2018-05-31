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

puts '-----------------------'

# метод принимает один параметр, блок за параметр не считается, но тут блок именован
def self.mtp a, &block
  p a
  if block_given?
    p "var - #{block.call("2")}"
  end
end

mtp 100 do |param|
  "#{param} - huy"
end
mtp 200

puts '-----------------------'

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
  p "var - #{block.call("2")}"
end

stp do |param|
  "#{param} - huy"
end

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
