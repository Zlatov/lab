#!/usr/bin/env ruby

# require 'tiny_tds'
require 'awesome_print'

# server = 'localhost'
# database = '<database>'
# username = 'sa'
# password = ENV['MYSQL_PWD']

password = ENV['MYSQL_PWD']
print 'password: '.red; puts password
exit

server = '10.192.5.3'
# server = 'clustersql1c.newstar.ru'
database = 'DataExchange'
username = 'dataexchange'
password = 'EXdata358'


# srv: 10.192.5.3
# dbname: DataExchange
# usr: dataexchange
# pwd: EXdata358 

print 'password: '.red; puts password

client = TinyTds::Client.new \
  username: username,
  password: password, 
  host: server,
  port: 1433,
  database: database
  # azure: true

puts "Reading data from table"
# sql = "
#   SELECT TOP 20 pc.Name as CategoryName, p.name as ProductName
#   FROM [SalesLT].[ProductCategory] pc
#   JOIN [SalesLT].[Product] p
#   ON pc.productcategoryid = p.productcategoryid
# "
sql = "SELECT name FROM master.sys.databases;"
# sql = "EXEC sp_databases"

result = client.execute(sql)
result.each do |row|
  p row
end

client.close
