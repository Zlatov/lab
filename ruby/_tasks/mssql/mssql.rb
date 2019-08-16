#!/usr/bin/env ruby

require 'tiny_tds'

server = '<server>.database.windows.net'
database = '<database>'
username = '<username>'
password = '<password>'

client = TinyTds::Client.new \
  username: username,
  password: password, 
  host: server,
  port: 1433,
  database: database,
  azure: true

puts "Reading data from table"
tsql = "
  SELECT TOP 20 pc.Name as CategoryName, p.name as ProductName
  FROM [SalesLT].[ProductCategory] pc
  JOIN [SalesLT].[Product] p
  ON pc.productcategoryid = p.productcategoryid
"

result = client.execute(tsql)
result.each do |row|
  puts row
end
