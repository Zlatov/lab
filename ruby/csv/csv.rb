# encoding: UTF-8
require 'awesome_print'
require 'csv'

CSV.open("temp.csv", "w") do |csv|
  csv << ["row", "of", "CSV", "data"]
  csv << ["another", "row"]
end

puts 'Разделитель'.green
CSV.open("temp.csv", "w", :col_sep => "\t") do |csv|
  csv << ["row", "of", "CSV", "data"]
  csv << ["another", "row"]
end

a = CSV.generate do |csv|
  csv << ["row", "of", "CSV", "data"]
  csv << ["another", "row"]
end

print 'a: '.red; p a

csv_string = ["CSV", "data"].to_csv   # to CSV
csv_array  = "CSV,String".parse_csv   # from CS

print 'csv_string: '.red; p csv_string
print 'csv_array: '.red; p csv_array
