class Movie < ActiveRecord::Base
  validates :title, presence: true, uniqueness: {case_insensitive: true}
end
