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

  after_update :reset_product_property_if_value_type_changed
  # Если изменить тип фильтра при его редактировании, то необходимо удалить все
  # назначенные значения свойств у товаров.
  def reset_product_property_if_value_type_changed
    reset_product_property if saved_change_to_attribute?(:value_type)
  end
  # Если удалили фильтр, тогда удаляем назначенные значения свойств у товаров.
  def reset_product_property
    Product.where("property_values ? '#{id}'").update_all("property_values = property_values - '#{id}'")
  end
end
