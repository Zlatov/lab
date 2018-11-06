#!/usr/bin/env ruby
require 'awesome_print'

puts 'Запустит шел! без башэрси'.green
a = system(
  %Q(echo "${PATH}")
)
print 'a: '.red; puts a

puts 'Запустит баш с башэрси'.green
a = system(
  "bash",
  "-lic",
  "echo \"${PATH}\""
)
print 'a: '.red; puts a

puts 'Запустит баш без башэрси'.green
a = system(
  %Q(./nologin)
)
print 'a: '.red; puts a

puts 'Запустит баш с башэрси'.green
a = system(
  %Q(./login)
)
print 'a: '.red; puts a
