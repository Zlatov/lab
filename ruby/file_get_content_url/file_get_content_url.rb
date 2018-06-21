# !/home/iadfeshchm/.rbenv/shims/ruby -w

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
require 'awesome_print'


# url = 'http://zenonline.ru/cgi-bin/articles/client.cgi?action=load_articleslist&phil_id=13&year=2010&month=8'

url = 'http://www.zenonline.ru/techno/conspicuity/why.htm'
# header: <div align="CENTER" class="title">Будь бдителен, знай SCOTCHLITE 983 "в лицо"</div>


response = HTTP.get(url)
html = response.body.to_s

# header = html.match(/<div align="CENTER" class="title">(.*?)<\/div>/im)[1]
# html = html.match(/(<table width="600" border="0" cellspacing="0" cellpadding="0">.*?<\/table>)/im)[1]
# p header
# p html

body = html.match(/<body.*?>(.*?)<\/body>/im)[1]
print 'body: '.red; puts body
