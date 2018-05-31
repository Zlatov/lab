a = (1..1000).to_a
b = a.length
i = 0
a.each do |c|
  printf "%4s / %s\r", i+= 1, b
  # $stdout.flush
  sleep 0.001
end
puts
