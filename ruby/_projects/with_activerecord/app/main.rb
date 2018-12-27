#!/usr/bin/env ruby
require 'active_record'
require_relative './models/movie'

def db_configuration
  db_configuration_file = File.join(File.expand_path('..', __FILE__), '..', 'db', 'config.yml')
  YAML.load(File.read(db_configuration_file))
end

ActiveRecord::Base.establish_connection(db_configuration["development"])

print "Give me the title of the movie: "
title = gets.chomp

title = Movie.new(title: title)
title.save!

puts "Number of movies in your database: #{Movie.count}"
puts "Bye!"
