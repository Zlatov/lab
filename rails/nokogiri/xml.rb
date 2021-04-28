
imports = []
Nokogiri::XML::Reader(response).each do |node|
  if node.name == 'row' && node.node_type == Nokogiri::XML::Reader::TYPE_ELEMENT
    data = Hash.from_xml(node.outer_xml)&.[]('row')&.[]('Value')
    import = {}
    import[:code] = data[1]
    import[:affiliate_code] = data[0]
    import[:storehouse_code] = data[3]
    import[:amount] = data[2].to_f
    imports << import
  end
end
