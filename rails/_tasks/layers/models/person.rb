class Person < ApplicationRecord
  DEFAULT_COLOR = "#fcaa84"
  belongs_to :organization

  validates_presence_of :username, :email, :address
end
