# Проверка "точка внутри полигона"
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

# Дистанции до края
def distance_transform(grid, width, height)
  inf = 1_000_000
  dist = Array.new(height){Array.new(width, inf)}

  # === 1. границы ===
  height.times do |y|
    width.times do |x|
      if grid[y][x]
        # если рядом есть "вне фигуры" → это граница
        neighbors = [
          [x-1,y],[x+1,y],[x,y-1],[x,y+1]
        ]

        if neighbors.any? { |nx,ny|
          nx < 0 || ny < 0 || nx >= width || ny >= height || !grid[ny][nx]
        }
          dist[y][x] = 0
        end
      end
    end
  end

  # === 2. forward pass ===
  height.times do |y|
    width.times do |x|
      next unless grid[y][x]

      dist[y][x] = [
        dist[y][x],
        (x > 0     ? dist[y][x-1] + 1   : inf),
        (y > 0     ? dist[y-1][x] + 1   : inf),
        (x > 0 && y > 0 ? dist[y-1][x-1] + 1.4 : inf),
        (x < width-1 && y > 0 ? dist[y-1][x+1] + 1.4 : inf)
      ].min
    end
  end

  # === 3. backward pass ===
  (height-1).downto(0) do |y|
    (width-1).downto(0) do |x|
      next unless grid[y][x]

      dist[y][x] = [
        dist[y][x],
        (x < width-1 ? dist[y][x+1] + 1 : inf),
        (y < height-1 ? dist[y+1][x] + 1 : inf),
        (x < width-1 && y < height-1 ? dist[y+1][x+1] + 1.4 : inf),
        (x > 0 && y < height-1 ? dist[y+1][x-1] + 1.4 : inf)
      ].min
    end
  end

  dist
end

# Направленность в каждой точке
def gradient(dist, x, y, width, height)
  x1 = [x-1, 0].max
  x2 = [x+1, width-1].min
  y1 = [y-1, 0].max
  y2 = [y+1, height-1].min

  dx = dist[y][x2] - dist[y][x1]
  dy = dist[y2][x] - dist[y1][x]

  len = Math.sqrt(dx*dx + dy*dy) + 1e-6

  nx = dx / len
  ny = dy / len

  # tangent
  tx = -ny
  ty = nx

  {
    normal: [nx, ny],
    tangent: [tx, ty]
  }
end
