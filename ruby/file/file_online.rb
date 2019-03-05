# encoding: UTF-8
require 'fileutils'
require 'json'
$stdout.sync = true

sleep 1
file = File.open 'temp', 'w+'
<<-RUBY
file.puts "1"
puts file.pos
file.pos = 0
puts file.pos
file.read
puts file.pos
RUBY
.split("\n")
.each do |command|
  begin 
    eval(command).inspect
    sleep 1
  rescue => e
    puts e.to_s + "\n" + e.backtrace.join("\n")
  ensure
    # file.close
  end
end
file.close
