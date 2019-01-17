#!/usr/bin/env ruby
require 'pg'
require 'active_record'
require 'byebug'

require_relative "../migration/migration/settings"
require_relative "../model/base"
require_relative "../model/stat_date"
require_relative "../model/stat_email"
require_relative "../model/stat_status"
require_relative "../model/stat_label"
require_relative "../model/stat_relay"
require_relative "nicks"

byebug

puts "Done."
