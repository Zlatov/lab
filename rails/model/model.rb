class Model < ApplicationRecord
  # Kaminari (pagination)
  paginates_per 3

  enum value_type: [:string, :integer, :float]
end
