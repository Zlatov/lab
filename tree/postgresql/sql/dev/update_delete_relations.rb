# encoding: UTF-8
require 'rubygems'
require 'awesome_print'
require 'pg'

begin
  connection = PG.connect :dbname => 'lab', :user => 'lab', :password => 'lab'
  sql = [
    "
      SELECT *
      FROM tree_rel r1
      INNER JOIN tree_rel r2 ON r2.did = r1.did
      INNER JOIN tree_rel r3 ON r3.did = $1::int AND r3.aid <> $1::int
        AND r3.aid = r2.aid
      WHERE r1.aid = $1::int
    ",
    "
      SELECT *
      FROM (
        SELECT aid
        FROM tree_rel
        WHERE did = $1::int AND aid != $1::int
      ) AS a
      CROSS JOIN (
        SELECT did
        FROM tree_rel
        WHERE aid = $1::int
      ) AS b
    ",
  ]
  2.times do |test_id|
    t = Time.now
    10000.times do |i|
      connection.exec_params sql[test_id], [3]
    end
    t-= Time.now
    print 't: '.red; puts t
  end
rescue PG::Error => e
  puts e.message 
ensure
  connection.close if connection
end

