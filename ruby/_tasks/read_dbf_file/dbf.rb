# encoding: UTF-8
require 'rubygems'
require 'awesome_print'
require 'pathname'
require 'dbf'

data = File.open Pathname.new(ENV['HOME']).join('kladr', 'STREET.dbf')
# widgets = DBF::Table.new(data)
widgets = DBF::Table.new(data, nil, 'cp866')

print 'widgets.schema: '.red; puts widgets.schema

# widgets.each do |record|
#   record
# end

puts widgets.first.attributes

puts 'Done.'
