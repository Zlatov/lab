# encoding: UTF-8
require_relative '../colorize/colorize'
require 'rubygems'
require 'awesome_print'
require 'mysql2'

$pdo = Mysql2::Client.new(
  :host => "localhost",
  :username => "lab",
  :password => 'lab',
  :database => 'lab'
)

sql = 'DROP TABLE IF EXISTS `test`;'
$pdo.query sql
sql = 'CREATE TABLE `test` (`numbers` INT, `texts` VARCHAR(255));'
$pdo.query sql

# $pdo.close
