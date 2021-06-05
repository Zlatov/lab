require 'awesome_print'
require 'securerandom'

puts SecureRandom.hex(10) #=> "52750b30ffbc7de3b362"
puts SecureRandom.hex(10) #=> "92b15d6c8dc4beb5f559"
puts SecureRandom.hex(11) #=> "39b290146bea6ce975c37cfc23"

# 1 Байт - 8 бит
puts "FF".to_i(16)
puts "11111111".to_i(2)

# postgres bigint тип данных кодируются восемью Байтами
puts "FFFFFFFFFFFFFFFF".to_i(16)/2
puts SecureRandom.hex(8) #=> "52750b30ffbc7de3b362"
