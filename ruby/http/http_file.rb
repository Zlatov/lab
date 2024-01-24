require 'awesome_print'
require 'net/http'
require 'uri'

uri = URI('https://ru-wotp.lesta.ru/dcont/tankopedia_images/r105_bt_7a/r105_bt_7a_icon.svg')

content = Net::HTTP.get(uri)
File.write('temp_icon.svg', content.force_encoding('utf-8'))

# 
# ИЛИ
# 

response = Net::HTTP.get_response(uri)
if response.is_a? Net::HTTPSuccess
  File.write('temp_icon2.svg', response.body.force_encoding('utf-8'))
else
  print 'response.message: '.red; puts response.message
end
