# https://gist.github.com/carolineartz/10276637

require 'awesome_print'
require 'nokogiri'
require 'active_support/all'

puts 'Как читать ноду (Hash.from_xml | Nokogiri::XML)'.green
Nokogiri::XML::Reader(File.open('./data.xml')).each do |node|
  next unless node.name == 'food' && node.node_type == Nokogiri::XML::Reader::TYPE_ELEMENT
  print 'node.inner_xml [String]: '.red; puts node.inner_xml
  print 'node.outer_xml [String]: '.red; puts node.outer_xml
  data = Hash.from_xml(node.outer_xml)['food']
  print 'data [Hash]: '.red; puts data
  food = Nokogiri::XML(node.outer_xml).at('./food')
  print 'food [#Nokogiri::XML::Element]: '.red; puts food
end

# imports = []
# Nokogiri::XML::Reader(response).each do |node|
#   if node.name == 'row' && node.node_type == Nokogiri::XML::Reader::TYPE_ELEMENT
#     data = Hash.from_xml(node.outer_xml)&.[]('row')&.[]('Value')
#     import = {}
#     import[:code] = data[1]
#     import[:affiliate_code] = data[0]
#     import[:storehouse_code] = data[3]
#     import[:amount] = data[2].to_f
#     imports << import
#   end
# end

puts 'Чтение XML как бы построчно'.green
response = File.open('./data.xml')
row_count = Nokogiri::XML(response).search('food').count
print 'row_count: '.red; puts row_count
import_data = []
response.pos = 0 if response.is_a? File
Nokogiri::XML::Reader(response).each do |node|
  next unless node.name == 'food' && node.node_type == Nokogiri::XML::Reader::TYPE_ELEMENT
  node_data = Hash.from_xml(node.outer_xml)['food']
  # node_data = Nokogiri::XML(node.outer_xml).at('./food')
  record_data = {}
  record_data[:name] = node_data['name']
  record_data[:price] = node_data['price']
  record_data[:description] = node_data['description']
  record_data[:calories] = node_data['calories']
  import_data << record_data
end
print 'import_data: '.red; p import_data

=begin
    xml_warehouses = xml(__method__, options[:use_temp])

    row_count = Nokogiri::XML(xml_warehouses).search('row').count
    xml_warehouses.pos = 0 if xml_warehouses.is_a? File
    i = 0
    Nokogiri::XML::Reader(xml_warehouses).each do |node|
      next unless node.name == 'row' && node.node_type == Nokogiri::XML::Reader::TYPE_ELEMENT

      i += 1
      progress = (i * 100 / row_count).floor

      doc = Nokogiri::XML(node.outer_xml)
      doc.remove_namespaces!
      array_data = doc.xpath('//row/Value').map(&:text)
      data = {
        code: array_data[1],
        name: array_data[2],
        address: (array_data[3].present? ? array_data[3] : nil)
      }
      yield data, progress
    end
=end
