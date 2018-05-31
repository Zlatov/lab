# encoding: UTF-8
require 'awesome_print'
a = [
  :gray, :red, :green, :yellow, :blue, :purple, :cyan, :white,
  :black, :redish, :greenish, :yellowish, :blueish, :purpleish, :cyanish, :pale
]
a.each do |x|
  printf "%s ASDASD\n".send(x), x
end
