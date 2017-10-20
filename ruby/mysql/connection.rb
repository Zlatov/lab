# encoding: UTF-8
require_relative '../colorize/colorize'
require 'rubygems'
require 'mysql2'
client = Mysql2::Client.new(
  :host => "localhost",
  :username => "root",
  :password => 'businessAz8',
  :database => 'admin'
)
results = client.query('SELECT * FROM `seo` LIMIT 10;')
results.each do |row|
  row_hash = row.to_h
  print 'row_hash: '.red; puts row_hash
end
