# ruby 01.rb

WIDTH  = 100
HEIGHT = 100

# === 1. Векторная фигура (квадрат с дыркой) ===
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

# === 2. Проверка "точка внутри полигона" ===
def point_in_polygon?(x, y, polygon)
  inside = false
  j = polygon.size - 1

  polygon.each_with_index do |(xi, yi), i|
    xj, yj = polygon[j]

    intersect = ((yi > y) != (yj > y)) &&
      (x < (xj - xi) * (y - yi) / (yj - yi + 0.00001) + xi)

    inside = !inside if intersect
    j = i
  end

  inside
end

def point_in_shape?(x, y, shape)
  return false unless point_in_polygon?(x, y, shape[:outer])

  shape[:holes].each do |hole|
    return false if point_in_polygon?(x, y, hole)
  end

  true
end

# === 3. Растризация ===
grid = Array.new(HEIGHT) { Array.new(WIDTH, false) }

HEIGHT.times do |y|
  WIDTH.times do |x|
    grid[y][x] = point_in_shape?(x, y, shape)
  end
end

# === 4. Distance transform (очень простой brute force) ===
def distance_to_edge(x, y, grid)
  min_dist = Float::INFINITY

  grid.each_with_index do |row, yy|
    row.each_with_index do |val, xx|
      # ищем границу: сосед отличается
      if val != grid[y][x]
        dist = Math.sqrt((x - xx)**2 + (y - yy)**2)
        min_dist = dist if dist < min_dist
      end
    end
  end

  min_dist
end

distances = Array.new(HEIGHT) { Array.new(WIDTH, 0.0) }

HEIGHT.times do |y|
  WIDTH.times do |x|
    if grid[y][x]
      distances[y][x] = distance_to_edge(x, y, grid)
    end
  end
end

# === 5. Вывод в консоль ===
HEIGHT.times do |y|
  WIDTH.times do |x|
    if !grid[y][x]
      print " "
    else
      d = distances[y][x]
      print d > 10 ? "." : "*"
    end
  end
  puts
end
