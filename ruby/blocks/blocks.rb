# encoding: UTF-8
require 'rubygems'
require 'byebug'
require 'mini_magick'
require 'awesome_print'

# byebug

def self.dsl
  p "var - #{yield}"
end

dsl do
  "huy"
end

puts '-----------------------'


def self.ftp
  p "var - #{yield("2")}"
end

ftp do |param|
  "#{param} - huy"
end

puts '-----------------------'


def self.mtp &block
  p "var - #{block.call("2")}"
end

mtp do |param|
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

def self.stp &block
  another block
  another 1, &block
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
