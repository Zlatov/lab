# encoding: UTF-8
require_relative '../colorize/colorize'

def declension number, words
  if words.is_a? ::String
    words = words.split(',').map{|v|v.strip}
  end
  words[1] = words[0] if (!words[1]||words[1].empty?)
  words[2] = words[1] if (!words[2]||words[2].empty?)
  number = number.abs%100
  if 11 <= number && number <= 19
    return words[0]
  end
  i = number%10
  case i
  when 1
    return words[1]
  when 2..4
    return words[2]
  else
    return words[0]
  end
end

# 40.times{ |i|
#   print i.to_s + ' '
#   puts declension i, ['ежей', 'ёж', 'ежа']
# }
