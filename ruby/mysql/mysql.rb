load 'connection.rb'

# Просто выполнить SQL
sql = 'INSERT INTO `test` (`numbers`) VALUES (1);'
$pdo.query sql
sql = 'INSERT INTO `test` (`numbers`) VALUES (2);'
$pdo.query sql

# Подготовить выражения и выполнить его n-раз
sql = 'INSERT INTO `test` (`numbers`) VALUES (?);'
stt = $pdo.prepare sql
(3..9).each{|n|stt.execute n}

# Экранирование
text = $pdo.escape 'asd\'"`|^{[]}#%asds'
$pdo.query "INSERT INTO `test` (`texts`) VALUES ('#{text}')"

sql = 'SELECT `nambers` FROM `tests` WHERE `numbers` > 2;'


results = $pdo.query('SELECT * FROM `test` LIMIT 10;')
results.each do |row|
  row_hash = row.to_h
  print 'row_hash: '.red; ap row_hash
end
