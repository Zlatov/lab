# encoding: UTF-8
require 'rubygems'
require 'awesome_print'
require "mini_magick"

image_path = "images/temp_deer-nature.jpg"
abort 'Изображение не найдено' if !File.exist?(image_path)
thumbnail_path = "images/temp_thumbnail.png"



print 'image_path: '.red; puts image_path

image = MiniMagick::Image.open(image_path)

print 'image.path: '.red; puts image.path

image.resize "100x100"
image.format "png"
image.write "#{thumbnail_path}"
