# encoding: UTF-8
require_relative '../colorize/colorize'
require 'rubygems'
require 'mini_magick'

image = MiniMagick::Image.open('data/MARBLES.TIF')
image.format 'png'
image.resize '100x100>'
image.write 'data/MARBLES.png'
