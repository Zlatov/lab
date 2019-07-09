class Model < ActiveRecord::Base

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
