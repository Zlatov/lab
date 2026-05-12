# ruby 03.rb

require 'awesome_print'
require 'json'
require './lib'

WIDTH  = 100
HEIGHT = 100

# Фигура
shape = {
  outer: [
    [10, 10],
    [90, 10],
    [90, 90],
    [10, 90]
  ],
  holes: [
    [
      [40, 40],
      [60, 40],
      [60, 60],
      [40, 60]
    ]
  ]
}

# Растеризация фигуры
shape_grid = Array.new(HEIGHT){Array.new(WIDTH, false)}
HEIGHT.times do |y|
  WIDTH.times do |x|
    shape_grid[y][x] = point_in_shape?(x, y, shape)
  end
end

# Вывод фигуры
HEIGHT.times do |y|
  WIDTH.times do |x|
    print shape_grid[y][x] ? "█" : " "
  end
  puts
end
File.write("shape_grid.json", JSON.pretty_generate(shape_grid))

# Расстояния до границ
distances = distance_transform(shape_grid, WIDTH, HEIGHT)

# Вывод приемлимых позиций, для определённого расстояния до края
distance = 4
HEIGHT.times do |y|
  WIDTH.times do |x|
    print distances[y][x] >= distance && shape_grid[y][x] ? "█".green : "█".red
  end
  puts
end

# Напрвленность в каждой точке
gradients = Array.new(HEIGHT){Array.new(WIDTH, nil)}
angles = Array.new(HEIGHT){Array.new(WIDTH, nil)}
HEIGHT.times do |y|
  WIDTH.times do |x|
    gradients[x][y] = gradient(distances, x, y, WIDTH, HEIGHT)
    angles[x][y] = Math.atan2(gradients[x][y][:tangent][1], gradients[x][y][:tangent][0])
  end
end
print 'gradients[0][0]: '.red; puts gradients[0][0]
print 'angles[0][0]: '.red; puts angles[0][0]
print 'gradients[11][12]: '.red; puts gradients[11][12]
print 'angles[11][12]: '.red; puts angles[11][12]
