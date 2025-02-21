# encoding: UTF-8
require 'open-uri'

# open('url.txt', 'wb') do |file|
#   file << open('http://www.zenobaner.ru/images/catalog/s_16.giff').read
# end

begin
  # file_content = open('http://www.zenobaner.ru/images/catalog/s_16.gif').read
  file_content = URI.open('https://zenonline.ru/admin/unpublic/files/product/00000020479/images/origin_00000020479_154997192621ec.png').read
  # open('url.gif', 'wb') do |file|
  open('origin_00000020479_154997192621ec.png', 'wb') do |file|
    file << file_content if !file_content.nil?&&!file_content.empty?
  end
rescue => e
  # File.delete 'url.txt'
  p e.message
end
