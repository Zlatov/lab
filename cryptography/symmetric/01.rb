require 'awesome_print'
require 'unicode_utils'

DELTA = 123
KEYS = [6937413, 578935, 374813, 987563]

temp_encoded = File.open 'temp_encoded.txt', 'wb'
File.open('temp_source.txt', 'rb') do |file|
  data = file.read(5)
  while !data.nil?
    # data.force_encoding('ASCII-8BIT')
    bytes = data.bytes
    print 'bytes: '.red; p bytes
    sum = 0
    x1, x2, x3, x4, x5 = bytes
    x2 ||= 0
    x3 ||= 0
    x4 ||= 0
    x5 ||= 0
    32.times do |i|
      sum = sum + DELTA
      x1 = x1 + ( ( (x2 << 4) + KEYS[0] ) ^ ( x2+sum ) ^ ( (x2 >> 5) + KEYS[1]) ) & 255
      x2 = x2 + ( ( (x3 << 4) + KEYS[0] ) ^ ( x3+sum ) ^ ( (x3 >> 5) + KEYS[1]) ) & 255
      x3 = x3 + ( ( (x4 << 4) + KEYS[0] ) ^ ( x4+sum ) ^ ( (x4 >> 5) + KEYS[1]) ) & 255
      x4 = x4 + ( ( (x5 << 4) + KEYS[0] ) ^ ( x5+sum ) ^ ( (x5 >> 5) + KEYS[1]) ) & 255
      x5 = x5 + ( ( (x1 << 4) + KEYS[2] ) ^ ( x1+sum ) ^ ( (x1 >> 5) + KEYS[3]) ) & 255
    end
    new_bytes = [x1, x2, x3, x4, x5]
    temp_encoded.write new_bytes.pack("c*")
    data = file.read(5)
  end
end
temp_encoded.close

temp_decoded = File.open 'temp_decoded.txt', 'wb'
File.open('temp_encoded.txt', 'rb') do |file|
  data = file.read(5)
  while !data.nil?
    # data.force_encoding('ASCII-8BIT')
    bytes = data.bytes
    sum = 32 * DELTA
    x1, x2, x3, x4, x5 = bytes
    32.times do |i|
      x5 = x5 - ( ( (x1 << 4) + KEYS[2] ) ^ ( x1+sum ) ^ ( (x1 >> 5) + KEYS[3]) ) & 255
      x4 = x4 - ( ( (x5 << 4) + KEYS[0] ) ^ ( x5+sum ) ^ ( (x5 >> 5) + KEYS[1]) ) & 255
      x3 = x3 - ( ( (x4 << 4) + KEYS[0] ) ^ ( x4+sum ) ^ ( (x4 >> 5) + KEYS[1]) ) & 255
      x2 = x2 - ( ( (x3 << 4) + KEYS[0] ) ^ ( x3+sum ) ^ ( (x3 >> 5) + KEYS[1]) ) & 255
      x1 = x1 - ( ( (x2 << 4) + KEYS[0] ) ^ ( x2+sum ) ^ ( (x2 >> 5) + KEYS[1]) ) & 255
      sum = sum - DELTA
    end
    new_bytes = [x1, x2, x3, x4, x5]
    data = file.read(5)
    if data.nil?
      nb_length = new_bytes.length
      new_bytes.reverse.each_with_index do |e, i|
        break if e != 0
        new_bytes.delete_at nb_length - i - 1
      end
    end
    temp_decoded.write new_bytes.pack("c*")
    # .force_encoding('UTF-8')
  end
end
temp_decoded.close

a = 0b11111111111111111111111111111111
print 'a: '.red; puts a
