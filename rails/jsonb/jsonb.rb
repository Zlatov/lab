# https://nandovieira.com/using-postgresql-and-jsonb-with-ruby-on-rails

class User < ActiveRecord::Base
  store_accessor :preferences, :blog, :github, :twitter
  # Значение по умолчанию.
  def twitter
    read_store_attribute(:preferences, :twitter) || "@#{username}"
  end

  store_accessor :details, :telegram
  def telegram
    super() == 'true' || super() == true
  end
  def telegram=(value)
    super(value == 'true' || value == true)
  end
end
