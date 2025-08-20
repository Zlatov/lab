require 'awesome_print'
require 'securerandom'

puts SecureRandom.hex(10) #=> "52750b30ffbc7de3b362"
puts SecureRandom.hex(10) #=> "92b15d6c8dc4beb5f559"
puts SecureRandom.hex(11) #=> "39b290146bea6ce975c37cfc23"
# exit 0

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

require 'digest'
require "base64"
require 'openssl'

# code_verifier = 'ZA3qGGmLS2l6_tfMCz1qQPxSeukt1W8QNAN7njYfwtA'
code_verifier = SecureRandom.hex(64)
print 'code_verifier: '.red; puts code_verifier

# code_challenge = Base64.encode64(
code_challenge = Base64.urlsafe_encode64(
  # Digest::SHA2.new(256).hexdigest(code_verifier)
  # Digest::SHA2.new(256).digest(code_verifier)
  Digest::SHA256.new.digest(code_verifier)
# ).tr("+/", "-_").tr("=", "")
).gsub('=', '')
print 'code_challenge: '.red; p code_challenge

code_challenge2 = Base64.urlsafe_encode64(
  OpenSSL::Digest::SHA256.digest(code_verifier)
).gsub(/=/, '')
print 'code_challenge2: '.red; p code_challenge2


print 'true code_challenge: '.red; p '5wb9Vlb2DAoCuHhpS6Fl56SXwDx4XpQTkEuY2IsKVuQ'
puts code_challenge == code_challenge2
