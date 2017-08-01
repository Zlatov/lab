# encoding: UTF-8
require 'fileutils'
require_relative '../colorize/colorize'

path_to_file = './data/json.json'
file = File.open path_to_file, 'w'

sleep_time = 0
while ( file.flock(File::LOCK_EX|File::LOCK_NB)!=0 )
  sleep(1)
  sleep_time+=1
  if sleep_time > 10
    raise 'Слишком долго ждем!'
  end
end
gg = file.flock File::LOCK_EX|File::LOCK_NB
print 'gg: '.light_blue; puts gg
gg = file.flock File::LOCK_EX|File::LOCK_NB
print 'gg: '.light_blue; puts gg
gg = file.flock File::LOCK_EX|File::LOCK_NB
print 'gg: '.light_blue; puts gg
# sleep(5)
file.flock File::LOCK_UN
# sleep(5)
file.close


    # sleep_time = 0
    # while ( sleep_time<3 )
    #   sleep(0.2)
    #   sleep_time+=0.2
    # end
