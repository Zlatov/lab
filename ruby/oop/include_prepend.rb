require "awesome_print"
require "active_support"
require "byebug"

module B
  def m
    puts 'B instance.m'.green
  end
end

class A
  include B

  def m
    puts 'A.instance.m'.green
    super
  end
end

print 'A.ancestors: '.red; p A.ancestors
A.new.m



module Bb
  def m
    puts 'Bb instance.m'.green
    super
  end
end

class Aa
  prepend Bb

  def m
    puts 'Aa.instance.m'.green
  end
end

print 'Aa.ancestors: '.red; p Aa.ancestors
Aa.new.m
