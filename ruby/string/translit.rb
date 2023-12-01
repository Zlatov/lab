# encoding: UTF-8
require_relative '../colorize/colorize'
require 'digest'

require 'rubygems'
require 'russian'

def for_file_name string
  md5 = Digest::MD5.hexdigest(string).slice 0, 4
  string.gsub! ' ', '-'
  string.gsub! /[^a-z0-9_-]/i, '_'
  string + md5
end
a = 'Ваще "***"! 百度腾讯'
b = Russian.translit a
c = for_file_name Russian.translit(b)
print 'a: '.red; puts a
print 'b: '.red; puts b
print 'c: '.red; puts c

a = 'Русский ёж  - 度_腾 = №11# English'
b = Russian.translit(a).gsub!(/\s+/, '-').gsub!(/[^a-z0-9_-]+/i, '_')
print 'a: '.red; puts a
print 'b: '.red; puts b

module StringTranslit
  TRANSLIT_RULE = {
    'А' => 'A',  'Б' => 'B',  'В' => 'V',
    'Г' => 'G',  'Д' => 'D',  'Е' => 'E',
    'Ё' => 'Yo', 'Ж' => 'Zh', 'З' => 'Z',
    'И' => 'I',  'Й' => 'I',  'К' => 'K',
    'Л' => 'L',  'М' => 'M',  'Н' => 'N',
    'О' => 'O',  'П' => 'P',  'Р' => 'R',
    'С' => 'S',  'Т' => 'T',  'У' => 'U',
    'Ф' => 'F',  'Х' => 'H',  'Ц' => 'Ts',
    'Ч' => 'Ch', 'Ш' => 'Sh', 'Щ' => 'Shh',
    'Ъ' => '',   'Ы' => 'Y',  'Ь' => '',
    'Э' => 'E',  'Ю' => 'Yu', 'Я' => 'Ya',

    'а' => 'a',  'б' => 'b',  'в' => 'v',
    'г' => 'g',  'д' => 'd',  'е' => 'e',
    'ё' => 'yo', 'ж' => 'zh', 'з' => 'z',
    'и' => 'i',  'й' => 'y',  'к' => 'k',
    'л' => 'l',  'м' => 'm',  'н' => 'n',
    'о' => 'o',  'п' => 'p',  'р' => 'r',
    'с' => 's',  'т' => 't',  'у' => 'u',
    'ф' => 'f',  'х' => 'h',  'ц' => 'ts',
    'ч' => 'ch', 'ш' => 'sh', 'щ' => 'sch',
    'ъ' => '',   'ы' => 'y',  'ь' => '',
    'э' => 'e',  'ю' => 'yu', 'я' => 'ya'
  }.freeze

  def translit
    StringTranslit::TRANSLIT_RULE.each{|k,v| self.gsub!(k, v)}
    self
  end
end

String.include StringTranslit

puts '.translit без гема russian'.green
a = ' Русский ёж  - 度_腾 = №11# English Русский'
b = a.translit
print 'b: '.red; puts b
