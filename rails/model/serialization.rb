class Model < ApplicationRecord

  # Атрибуты разрешенные к сериализации (белый список).
  # Этот метод накладывает глобальное ограничение запрета полей при
  # вызове следующих методов:
  # .as_json(only: [:id, :name, …])
  # .to_json(only: [:id, :name, …])
  def attributes
    {
      "id" => nil,
      "email" => nil,
      "name" => nil,
      "created_at" => nil,
      # "updated_at" => nil,
    }
  end
end
