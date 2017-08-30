# encoding: UTF-8
require 'fileutils'
require_relative '../colorize/colorize'
$stdout.sync = true

path_to_file = './data/json.json'

file = File.open path_to_file

p file.mtime()
p File.mtime(path_to_file).strftime('%Y-%m-%d %H:%M:%S')
