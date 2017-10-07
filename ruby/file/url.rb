# encoding: UTF-8
require 'open-uri'

# open('url.txt', 'wb') do |file|
#   file << open('http://www.zenobaner.ru/images/catalog/s_16.giff').read
# end

begin
  file_content = open('http://www.zenobaner.ru/images/catalog/s_16.gif').read
  open('url.gif', 'wb') do |file|
    file << file_content if !file_content.nil?&&!file_content.empty?
  end
rescue => e
  # File.delete 'url.txt'
  p e.message
end
