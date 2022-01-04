# https://www.youtube.com/watch?v=Ae19vpQ14jwdf
# https://files.speakerdeck.com/presentations/bbeaaede66054273a83b219c1433ba54/prepared-rubyc.p
# 
# http://railscasts.com/episodes/416-form-objects?view=asciicast
# https://codeclimate.com/blog/7-ways-to-decompose-fat-activerecord-models/
# https://medium.com/@croatech/%D1%81%D0%BE%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D0%B5-form-objects-%D1%81-%D0%BF%D0%BE%D0%BC%D0%BE%D1%89%D1%8C%D1%8E-activemodel-%D0%B8-virtus-1e69e87201f4
# https://jaryl.medium.com/disciplined-rails-form-object-techniques-patterns-part-1-23cfffcaf429

# Модель с кучей условной логики
class Person < ApplicationRecord
  # Вирт атрибут - при галочке создать дефолтную организацию.
  attr_accessor :create_an_organization
  # Задать режим модерирования, виртуальный атрибут задаваемый в контроллере,
  # позволяет определить в каком разделе (режиме) происходит редактирование
  # модели для того, чтобы определить какие валидации запускать.
  attr_accessor :moderation_mode

  belongs_to :organization

  # Обязательные поля в любой форме
  validates_presence_of :username, :email, :address
  # Валидация мыла только при создании
  validates_confirmation_of :email, on: :create
  # Принятие условий только при создании
  validates_acceptance_of :terms_of_service, on: :create
  # Проверять профессию и место работы только при модерировании
  validates_presence_of :profession, :workplace if: :in_moderation_mode?

  # Гем геокодер
  geocoded_by :address
  before_save :geocode

  # имя пользователя к регистру при создании
  before_validation :strip_and_downcase_username, on: :create
  # дефолтное значение ... при создании
  before_validation :set_default_color_theme, on: :create

  # После создания добавить организацию 
  after_save :create_default_organization if: :create_organization?

  def create_default_organization
    Organization.create(address: address, title: "#{username}'s organization", person: self)
  end

  def in_moderation_mode?
    !!moderation_mode
  end

  def create_organization?
    !!create_an_organization
  end

  def strip_and_downcase_username
    # ...
  end

  def set_default_color_theme
    # ...
  end
end


# Где какие операции выполняются
#                                                    user          moderator
#                                                    create update create update
# strip_and_downcase_username                        x             x
# set_default_color_theme                            x
# validates_presence_of(:username, :email, :address) x      x      x      x
# validates_confirmation_of(:email)                  x             x
# validates_acceptance_of(terms_of_service)          x             x
# validates_presence_of(:profession, :workspace)     x      x
# geocode                                            x             x
# save                                               x      x      x      x
# create_organization                                x             x


# MVC - изначально слои. Слои rails:
# 
# Database                        Database
#                                    ↓
# ActiveRecord model              Models
#                                    ↓
# Service layer                   Services
#                                    ↓
# Api Ui Importers (Котроллеры)   Controllers

# В моделях нельзя вызывать сервисы


# Виды вавлидаций:
# Валидация модели для добавления корректных записей в базу данных.
# Валидация для специфичных форм.
# Валидация по логики приложения. Капча, валидация пароля...
# Валидация по бизнес логике.
