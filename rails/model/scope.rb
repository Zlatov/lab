class Model < ApplicationRecord

  scope :published, -> { where(published: true) }
  scope :user_orders, ->(user_id) { published.where(user_id: user_id) }
  scope :published, -> { where(published: true) } do
    def asd
      'asd'
    end
  end
  scope :user_orders, ->(user_id) { includes(:order_items).where({user_id: user_id, entity_id: nil}) } do
    # На фронтэнде есть поведение отображения, которое может зависить
    # от данных:
    # 1. Не передаваемых на фронтэнд;
    # 2. Расчитанных по сложной бизнес логике;
    # А так же, порой необходимо подготавливать данные к отображению на бэкэнде (дата),
    # ПОЭТОМУ тут, А НЕ В КОНТРОЛЛЕРЕ, прописываем
    # функционал преобразования бэкэнд данных во фронтэнд.
    def to_ui
      as_json(include: :order_items).each do |order|
        order[:is_collapsed] = true
        order[:datetime] = 
      end
    end
  end
end
