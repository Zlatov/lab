# encoding: UTF-8
require 'rubygems'
require 'awesome_print'

def includes?
  [1,2,3].each do |e|
    return true if e == 2
  end
  return false
end

print 'includes?: '.red; puts includes?