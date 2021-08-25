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

# Теоретическое количество записей в таблице Коммерчесикх предложений при
# следующих допущениях: 300 городов по 20 менеджеров в день создают 200 кп, на
# протяжении 20 лет = 20*365*300*20*200*2 = 17 520 000 000. 5Байт кодируют число
# в сотни миллиардов.
puts SecureRandom.hex(5) #=> "52750b30ffbc7de3b362"

puts SecureRandom.uuid
