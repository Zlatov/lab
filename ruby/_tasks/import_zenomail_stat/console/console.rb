#!/usr/bin/env ruby
require 'pg'
require 'active_record'
require 'byebug'

require_relative "../migration/migration/settings"
require_relative "../model/base"
require_relative "../model/stat_email"
require_relative "nicks"

byebug

puts "Done."
