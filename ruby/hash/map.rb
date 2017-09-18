# encoding: UTF-8

types = {
  vips: {
    abbr: 'ВиПС',
    name: 'Выставочные и презентационные системы',
    article: '000090100'
  },
  csp: {
    abbr: 'ЦСП',
    name: 'Цветные самоклеящиеся пленки',
    article: '000062000'
  },
  zhlm: {
    abbr: 'ЖЛМ',
    name: 'Жесткие листовые материалы',
    article: '000067000'
  },
  kmm: {
    abbr: 'ММиХ',
    name: 'Монтажные материалы инструменты и химия',
    article: '000064000'
  },
  tehnik: {
    abbr: 'Техник',
    name: 'Оборудование для рекламных производств',
    article: '000001547'
  },
  app: {
    abbr: 'АПП',
    name: 'Профили из пластика и металла',
    article: '000063000'
  },
  ntm: {
    abbr: 'СВМ',
    name: 'Световозвращающие материалы',
    article: '000065500'
  },
  rds: {
    abbr: 'РДС',
    name: 'Светотехника и неон',
    article: '000061000'
  },
  ttt: {
    abbr: 'ТТТ',
    name: 'Термотрансферные технологии',
    article: '000060000'
  },
  chcp: {
    abbr: 'МТЦП',
    name: 'Материалы и технологии для цифровой печати',
    article: '000068500'
  },
  shtt: {
    abbr: 'ШТТ',
    name: 'Шелкотрафаретные технологии',
    article: '000035667'
  },
  site: {
    abbr: 'Сайт',
    name: 'Каталог статических страниц сайта',
    article: nil
  },
  else: {
    abbr: 'Другое',
    name: 'Другое',
    article: nil
  }
}

a = types.map {|k,v|
  'a'
}

a = Hash[ types.map {|k,v| v[:sid] = k.to_s; [v[:abbr],v]} ]
b = types.merge(types) {|k,v| v }


sids = Hash[types.map { |k,v|
  if v[:article].nil?
    [nil, nil]
  else
    [v[:article].to_sym,k.to_s]
  end
}].select {|k,v| k!=nil}

p sids
puts ''

sids = Hash[ types.map { |k,v|
  -> k, v {
    return [nil,nil] if v[:article].nil?
    return [v[:article].to_sym, k.to_s]
  }.call k,v
}].select {|k,v| k!=nil}

p sids
puts ''
# p types


projects_sid = Array(types.map { |k,v| 
  if v[:article].nil?
    nil
  else
    k.to_s
  end
}).select {|v| !v.nil?}

p projects_sid
