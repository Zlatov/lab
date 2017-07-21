# encoding: UTF-8
string = 'zenonline.ru/vlad/articles/articles1827.html Распродажа! на 11%! '
a = ((string =~ /.+?articles\d+\.html.*/i) != nil)
p a

def сontains_text string, text
  ((string =~ /#{text}/) != nil)
end

p сontains_text 'asdf', 'a'
p сontains_text 'asdf', 'as'
p сontains_text 'asdf', 's'
p сontains_text 'asdf', 'f'
p сontains_text 'asdf', 'b'

v = '123333.21452345.23453254a'
is_version_format = !((v =~ /^\d+\.\d+\.\d+$/).nil?)
p is_version_format

p 'admin.ru/asd/sadf-sa_df/?asd=wfwрусские 123123123'.split(' ')[0].gsub(/[^a-z.\-_0-9]/, '')
