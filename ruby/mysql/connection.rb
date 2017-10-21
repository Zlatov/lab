# encoding: UTF-8
require_relative '../colorize/colorize'
require 'rubygems'
require 'mysql2'

client = Mysql2::Client.new(
  :host => "localhost",
  :username => "lab",
  :password => 'lab',
  :database => 'lab'
)

sql = 'CREATE TABLE IF NOT EXISTS `test` (`numbers` INT);'
client.query sql

results = client.query('SELECT * FROM `test` LIMIT 10;')
results.each do |row|
  row_hash = row.to_h
  print 'row_hash: '.red; puts row_hash
end
