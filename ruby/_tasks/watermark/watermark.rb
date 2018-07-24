# encoding: UTF-8
require 'rubygems'
require "mini_magick"
require 'awesome_print'

require_relative '../../_libs/watermarkize/watermarkize'

image_path = 'images/temp_ryzhaya-devushka-girl-smeh.jpg'
image_ext = File.extname image_path
watermark_path = 'images/temp_sample.png'
watermark2_path = 'images/temp_watermark.png'
output_path = "images/temp_output#{image_ext}"
output2_path = "images/temp_output2#{image_ext}"

image = MiniMagick::Image.open(image_path)
watermark = MiniMagick::Image.open(watermark_path)
watermark2 = MiniMagick::Image.open(watermark2_path)

result = image.composite(watermark) do |c|
  c.gravity "center"
  # c.geometry "+20+20" # copy second_image onto first_image from (20, 20)
  # c.compose "Over" # OverCompositeOp
end
result.write output_path

result = image
  .composite(watermark2){|c| c.geometry "+20+20"}
  .composite(watermark2){|c| c.geometry "+120+120"}
  .composite(watermark2){|c| c.geometry "+220+220"}
result.write output2_path

image = Watermarkize::Image.open image_path
image.mark watermark2_path, dx: 30, dy: 20
image.write output2_path
