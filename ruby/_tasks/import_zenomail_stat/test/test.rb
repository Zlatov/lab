#!/usr/bin/env ruby
require 'pg'
require 'active_record'
require 'byebug'

require 'date'
require 'active_support/all'

require_relative "../migration/migration/settings"
require_relative "../model/base"
require_relative "../model/stat_date"
require_relative "../model/stat_email"
require_relative "../model/stat_status"
require_relative "../model/stat_label"
require_relative "../model/stat_relay"
require_relative "../console/nicks"

puts Sr.delete_all
puts Sd.delete_all
puts Se.delete_all
puts Ss.delete_all
puts Sl.delete_all

puts d1 = Sd.create(date: DateTime.now)
puts d2 = Sd.create(date: DateTime.now - 1.day)
puts Sd.count
puts e1 = Se.create(email: 'a')
puts e2 = Se.create(email: 'b')
puts Se.count
puts s1 = Ss.create(delivered: true,  code: nil,   name: 'Доставлено.')
puts s2 = Ss.create(delivered: false, code: nil,   name: 'Не доставлено по неизвестной причине.')
puts s3 = Ss.create(delivered: false, code: '500', name: 'Синтаксическая ошибка, команда не распознана (также этот отклик может означать, что длина команды слишком большая).')
puts s4 = Ss.create(delivered: false, code: '501', name: 'Синтаксическая ошибка в команде или аргументе.')
puts s5 = Ss.create(delivered: false, code: '502', name: 'Команда распознана, но её реализация сервером не поддерживается.')
puts s6 = Ss.create(delivered: false, code: '503', name: 'Неверная последовательность команд.')
puts s7 = Ss.create(delivered: false, code: '504', name: 'Параметр команды сервером не поддерживается.')
puts s8 = Ss.create(delivered: false, code: '530', name: 'Сервер требует аутентификации для выполнения запрошенной команды.')
puts s9 = Ss.create(delivered: false, code: '534', name: 'Данный отклик означает, что выбранный механизм аутентификации для данного пользователя является не достаточно надежным.')
puts s10 = Ss.create(delivered: false, code: '535', name: 'Аутентификация отклонена сервером (например, ошибка в кодировании данных).')
puts s11 = Ss.create(delivered: false, code: '538', name: 'Выбранный метод аутентификации возможен только при зашифрованном канале связи.')
puts s12 = Ss.create(delivered: false, code: '550', name: 'Запрошенная операция невозможна – почтовый ящик недоступен (почтовый ящик не найден или нет доступа; команда отклонена локальной политикой безопасности).')
puts s13 = Ss.create(delivered: false, code: '551', name: 'Нелокальный пользователь.')
puts s14 = Ss.create(delivered: false, code: '552', name: 'Запрошенная почтовая команда прервана – превышено выделенное на сервере пространство.')
puts s15 = Ss.create(delivered: false, code: '553', name: 'Запрошенная почтовая команда прервана – недопустимое имя почтового ящика (возможно синтаксическая ошибка в имени).')
puts s16 = Ss.create(delivered: false, code: '554', name: 'Неудачная транзакция или отсутствие SMTP сервиса (при открытии сеанса передачи данных).')
puts Ss.count
puts l1 = Sl.create(label: 'a')
puts Sl.count

puts r1 = Sr.create(date_id: d1.id, email_id: e1.id, status_id: s1.id, label_id: l1.id, count: 2)
puts r1 = Sr.create(date_id: d1.id, email_id: e2.id, status_id: s1.id, label_id: nil, count: 2)
puts r2 = Sr.create(date_id: d2.id, email_id: e1.id, status_id: s1.id, label_id: l1.id, count: 1)
puts Sr.count

puts "Done."
