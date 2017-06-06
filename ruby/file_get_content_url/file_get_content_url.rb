# Запустить этот файл:
# ruby ./file_get_content_url.rb

# encoding: UTF-8

# require 'net/http'
# require 'uri'


# # def open(url)
#   Net::HTTP.get(URI.parse(url))
# end

# url = 'http://zenonline.ru/cgi-bin/articles/client.cgi?action=load_articleslist&phil_id=13&year=2010&month=8'
# url = 'http://www.zenonline.ru/techno/conspicuity/why.htm'
# page_content = open(url)
# puts page_content




require "http"


# url = 'http://zenonline.ru/cgi-bin/articles/client.cgi?action=load_articleslist&phil_id=13&year=2010&month=8'

url = 'http://www.zenonline.ru/techno/conspicuity/why.htm'
# header: <div align="CENTER" class="title">Будь бдителен, знай SCOTCHLITE 983 "в лицо"</div>


body = HTTP.get(url).body.to_s
header = body.match(/<div align="CENTER" class="title">(.*?)<\/div>/im)[1]
html = body.match(/(<table width="600" border="0" cellspacing="0" cellpadding="0">.*?<\/table>)/im)[1]
p header
p html


p 'done'
