class Model < ActiveRecord::Base

  # acceptance
  # Обязательный флажек "принять условия сервиса"
  validates :terms_of_service, acceptance: true
  validates :terms_of_service, acceptance: { message: 'must be abided' }
  validates :eula, acceptance: { accept: ['TRUE', 'accepted'] }

  # validates_associated
  # Каждый связанный подобъект тоже должен быть валиндеым, использовать только на одном конце
  has_many :books
  validates_associated :books

  # confirmation
  # Двойное подтверждение ввода confirmation. Создает виртуальный атрибут с добавлением "_confirmation"
  validates :email, confirmation: true
  validates :email_confirmation, presence: true

  # exclusion
  # значение НЕ включено в указанный набор.
  validates :subdomain, exclusion: { in: %w(www us ca jp), message: "%{value} is reserved." }

  # inclusion
  # включение в указанный набор
  validates :size, inclusion: { in: %w(small medium large), message: "%{value} is not a valid size" }

  # format
  # тестируя их на соответствие указанному регулярному выражению
  validates :legacy_code, format: { with: /\A[a-zA-Z]+\z/, message: "only allows letters" }

  # length
  # валидацию длины значений атрибутов. Он предлагает ряд опций, с помощью которых вы можете определить ограничения по длине разными способами:
  validates :name, length: { minimum: 2 }
  validates :bio, length: { maximum: 500 }
  validates :password, length: { in: 6..20 }
  validates :registration_number, length: { is: 6 }

  # numericality
  # только числовые значения.
  validates :points, numericality: true
  validates :games_played, numericality: { only_integer: true } # (/\A[+-]?\d+\z/)
  # :greater_than - больше
  # :greater_than_or_equal_to - больше или равно
  # :equal_to - равно
  # :less_than - меньше
  # :less_than_or_equal_to - меньше или равно
  # :other_than - отличаться
  # :odd - нечетным
  # :even - четным
  # По умолчанию numericality не допускает значения nil. Чтобы их разрешить, можно использовать опцию allow_nil: true.

  # presence
  # атрибуты не пустые
  validates :name, :login, :email, presence: true
  validates :name, :login, :email, presence: { strict: true } # Бросает исключение а не добавляет ошибку в модель
  validates :name, :login, :email, presence: true, allow_blank: false # и не пустая строка, но не подходит для булева поля (false == blank)
  validates :active, inclusion: { in: [ true, false ] } # (правильно валидировать булево)
  # Быть уверенным, что связь существует (существует ли сам связанный объект):
  has_one :account
  validates :account, presence: true

  # absence
  # атрибуты отсутствуют.
  validates :name, :login, :email, absence: true

  # uniqueness
  # значение атрибута уникально.
  validates :email, uniqueness: true
  # опция :scope для определения более двуух атрибутов для уникальности
  validates :name, uniqueness: {
    scope: :year,
    message: "should happen once per year",
    case_sensitive: false
  }
  validates_uniqueness_of :name, :case_sensitive => false

  # validates_with
  # передает запись в отдельный класс для валидации.
  class GoodnessValidator < ActiveModel::Validator
    def validate(record)
      if record.first_name == "Evil"
        record.errors[:base] << "This person is evil"
      end
    end
  end
  class Person < ApplicationRecord
    validates_with GoodnessValidator
    # Тоже отдельный класс валидации
    validates :pdf, limit_file_size: true
  end
  class LimitFileSizeValidator < ActiveModel::EachValidator
    def validate_each(record, attribute, value)
      if UploadedFile.size_limit_exceeded?(record.send(attribute).file, file_size_limit)
        record.errors[attribute] << "must not be larger than #{file_size_limit} MB"
      end
    end
  end


  validates :name,
    presence: true,
    length: {minimum: 1, maximum: 254}

  validates :email,
    presence: true,
    length: {minimum: 3, maximum: 254},
    format: {with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i}

  validates :phonenumber,
    presence: true,
    length: {minimum: 8, maximum: 64}

  validates :ogrn,
    presence: false, # Разрешает отсутствовать значению
    length: {is: 13},
    format: {with: /\d+/i},
    allow_nil: true

  # Булево поле
  validates :field, inclusion: { in: [ true, false ] }

  validate :valid_date, :valid_email

  def valid_date
    errors.add('asdasdff')
    errors.add(:name, :blank, message: "cannot be nil") if name.nil?
    errors.add(:name, :invalid, message: "cannot be nil") if name.nil?
  end
