# encoding: UTF-8
require_relative '../watermarkize'
require 'awesome_print'
require "mini_magick"

puts 'Tets throw exception'.green
begin
  image = Watermarkize::Image.open 'asd'
rescue Watermarkize::Image::Exception => e
  print 'e.message: '.red; puts e.message
end

image_path = 'images/test_1920-1080-nature.jpg'
image320_path = 'images/test_320-240-nature.jpg'
image800_path = 'images/test_800-600-nature.jpg'

watermark_path = 'images/test_watermark.png'
watermark80_path = 'images/test_watermark-80.png'
watermark120_path = 'images/test_watermark-120.png'

output_path = 'images/temp_output'
output_i800w120_path = 'images/temp_i800w120'
output_i320w80_path = 'images/temp_i320w80'
output_i320w120c_path = 'images/temp_i320w120c'

puts 'Test create instance'.green
image = Watermarkize::Image.open image_path
print 'image: '.red; puts image

puts 'Test mark'.green
b = image.mark watermark_path, dx: 400, dy: 400
print 'b: '.red; puts b
print 'image: '.red; puts image

puts 'Test save'.green
image.save output_path


puts 'Test i800w120'.green
image = Watermarkize::Image.open image800_path
image.mark watermark120_path, dx: 60, dy: 60
image.save output_i800w120_path

puts 'Test i320w80'.green
image = Watermarkize::Image.open image320_path
image.mark watermark80_path, dx: 40, dy: 40
image.save output_i320w80_path

puts 'Test i320w120c'.green
image = Watermarkize::Image.open image320_path
image.mark watermark120_path, repeat: false
image.save output_i320w120c_path
