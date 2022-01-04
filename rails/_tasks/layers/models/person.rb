class Person < ApplicationRecord
  DEFAULT_COLOR = "#fcaa84"
  belongs_to :organization

  validates_presence_of :username, :email, :address

  # Приделываем классический (не через гем Draper) декоратор к модели, чтобы не
  # хранить логику отображения тут.
  # 
  # Использовать во view так: person.ui.name
  def ui
    @ui ||= PersonPresenter.new(self)
  end
end
