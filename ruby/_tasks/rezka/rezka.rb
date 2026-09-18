require 'awesome_print'
require 'or-tools'

# 1. Исходные данные

# Заготовки (длина, количество)
billets = [
  {l: 1000, c: 100},
  {l: 1200, c: 50}
]
# Составные части для одного готового товара (длина, количество)
product = [
  {l: 300, c: 2},
  {l: 600, c: 3},
  {l: 750, c: 1}
]


# 2. Вариантов резок каждой заготовки

# Определение вариантов резок заготовки длиной length на части длинами parts
# Пример резок:
# [
#   {parts: {0 => 3, 1 => 0}, remnant: 100},
#   {parts: {0 => 1, 1 => 1}, remnant: 100},
# ]
# Значения в примере:
# {parts: {<индекс части> => <количество частей>,}, remnant: <остаток>}
def cut_variants(length, parts)
  result = []
  # Резка заготовки не считается завершенной если остаток по длине больше самой
  # маленькой части (минимизируем остатки)
  min_part = parts.min
  # Определим сколько раз каждая часть "входит" в заготовку, чтобы построить
  # декартово произведение всех вариантов резок.
  ranges = parts.map{|p| (0..length / p).to_a }
  d = ranges[0].product(*ranges[1..])
  # Переберём декартово произведение, counts это один вариант резки
  d.each do |counts|
    cut_length = 0
    counts.each.with_index do |count, index|
      cut_length += parts[index] * count
    end
    remnant = length - cut_length
    # Подходящая резка: не длиннее заготовки, остаток минимален.
    if cut_length <= length && remnant < min_part
      result << {parts: counts.map.with_index{|c, i| [i, c]}.to_h, remnant: remnant}
    end
  end
  result
end

# Целочисленный солвер
solver = ORTools::Solver.new("CBC")

# Соберём общий список вариантов, у каждого варианта своя переменная солвера:
# сколько раз применить этот вариант резки
variants = []
parts = product.map{|pr| pr[:l]}
billets.each.with_index do |billet, billet_index|
  # Варианты одной заготовки
  cv = cut_variants(billet[:l], parts)

  # Переменные этой заготовки
  billet_vars = []
  cv.each do |variant|
    var = solver.int_var(0, solver.infinity, "x#{variants.length}")
    variants << {billet: billet_index, parts: variant[:parts], remnant: variant[:remnant], var: var}
    billet_vars << var
  end

  # Ограничения по количеству заготовок
  # x₁ + x₂ + x₃ ≤ 100
  solver.add(solver.sum(billet_vars) <= billet[:c])
end

# Количество товаров
k = solver.int_var(0, solver.infinity, "k")

# Ограничения по количеству деталей: для каждой детали сумма по всем вариантам
# (сколько деталей даёт вариант * сколько раз его применили) должна покрыть K товаров
# x₁ + x₂ + 3x₃ + x₅ + 2x₆ + 4x₇ ≥ 2K
product.each.with_index do |pr, part_index|
  terms = []
  variants.each do |variant|
    count = variant[:parts][part_index]
    terms << variant[:var] * count if count > 0
  end
  solver.add(solver.sum(terms) >= pr[:c] * k)
end

# Цель: максимум товаров
solver.maximize(k)
status = solver.solve

# 3. Результат

if status == :optimal
  puts "Товаров: #{k.solution_value.round}".green
  variants.each do |variant|
    n = variant[:var].solution_value.round
    next if n == 0
    billet = billets[variant[:billet]]
    cut = variant[:parts].select{|i, c| c > 0}.map{|i, c| "#{parts[i]}x#{c}"}.join(' + ')
    puts "Заготовка #{billet[:l]}: #{cut}, остаток #{variant[:remnant]} — #{n} шт."
  end
else
  puts "Решение не найдено: #{status}".red
end
