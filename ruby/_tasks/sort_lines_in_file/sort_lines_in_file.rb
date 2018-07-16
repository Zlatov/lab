# encoding: UTF-8
require 'rubygems'
require 'awesome_print'

# file_path = 'temp_lines'
file_path = 'test_lines'
abort if !File.exist?(file_path)
result_file_path = 'temp_result'

puts 'START'.green
lines = []
File.readlines(file_path).each do |line|
  # print 'line: '.red; puts line
  lines.push line
end

lines.sort_by! do |line|
  # print 'line: '.red; puts line
  from = line[/^(rewrite\s+\S+)\s/i, 1]
  # print 'from: '.red; puts from
  len = from.nil? ? 0 : from.length
  len
end

# print 'lines.reverse: '.red; puts lines.reverse

result_file = File.open result_file_path, 'w+'

lines.reverse.each{|line|result_file.write line}

result_file.close

puts 'FINISH'.green

