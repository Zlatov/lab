# encoding: UTF-8
require_relative '../colorize/colorize'
require "open-uri"
require 'rubygems'
require 'mini_magick'

data = URI.parse("https://sign-forum.ru/styles/prosilver/theme/images/custom/logo.png").read

File.open 'logo.png', 'w+' do |file|
  file.write data
end




image = MiniMagick::Image.open('logo.png')
image2 = MiniMagick::Image.open('logo.png')
print 'image: '.red; puts image

a = image.dup
b = image.dup

a = a.resize '100x100>'
a.write 'logo100.png'
print 'a: '.red; puts a

b = b.resize '600x600>'
b.write 'logo600.png'
print 'b: '.red; puts b
