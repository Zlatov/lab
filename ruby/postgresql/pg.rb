# encoding: UTF-8
require 'rubygems'
require 'awesome_print'
require 'pg'
# connection = PG::Connection.open\
#   :dbname => 'lab',
#   :user => 'lab',
#   :password => 'lab'

begin
  connection = PG.connect :dbname => 'lab', :user => 'lab', :password => 'lab'
  puts connection.server_version

  result = connection.exec 'SELECT VERSION()'
  puts result.getvalue 0, 0

  result = connection.exec 'DROP TABLE IF EXISTS a'
  result = connection.exec '
    CREATE TABLE a (
      id SERIAL PRIMARY KEY,
      name VARCHAR(180) NOT NULL
    );
  '
  result = connection.exec "INSERT INTO a (name) VALUES ('asd'),('qwe'),('zxc'),('qwe ads'),('qwe zxc')"

  rs = connection.exec "SELECT * FROM a LIMIT 5"
  rs.each do |row|
    puts "%s %s" % [ row['id'], row['name'] ]
  end

  connection.prepare 'stm1', "SELECT * FROM a WHERE Id=$1"
  rs = connection.exec_prepared 'stm1', [3]
  puts rs.values

  stm = "SELECT $1::int AS a, $2::int AS b, $3::int AS c"
  rs = connection.exec_params(stm, [1, 2, 3])
  puts rs.values

rescue PG::Error => e
  puts e.message 
ensure
  connection.close if connection
end

