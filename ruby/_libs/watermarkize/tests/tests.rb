# encoding: UTF-8
require_relative '../watermarkize'
require 'awesome_print'
require "mini_magick"

begin
  image = Watermarkize::Image.open 'asd'
rescue Watermarkize::Image::Exception => e
  print 'e.message: '.red; puts e.message
end

image_path = 'images/test_1920-1080-nature.jpg'
watermark_path = 'images/test_watermark.png'

image = Watermarkize::Image.open image_path
image.mark watermark_path
