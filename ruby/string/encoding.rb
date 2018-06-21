cyr = File.read 'window-1251.txt'
puts cyr.force_encoding('cp1251').encode('utf-8', undef: :replace)
