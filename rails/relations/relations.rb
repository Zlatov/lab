# 
# :dependent
# Контролирует, что происходит с связанными объектами, когда их владелец уничтожается.
# Обратите внимание, что они реализованы как обратные вызовы, а Rails выполняет обратные вызовы по порядку.
# Следовательно, другие подобные обратные вызовы могут влиять на зависимое поведение и зависимое поведение может влиять на другие обратные вызовы.
# 
# :destroy — вызывает уничтожение всех связанных объектов.
# 
# :delete_all — заставляет все связанные объекты удаляться непосредственно из базы данных (поэтому обратные вызовы не будут выполняться).
# 
# :nullify — приводит к тому, что внешние ключи должны быть установлены в NULL. Обратные вызовы не выполняются.
# 
# :restrict_with_exception — вызывает исключение, если есть связанные записи.
# 
# :restrict_with_error — вызывает ошибку, добавляемую владельцу, если есть связанные объекты.
# 
# Если вы используете с опцией :through, ассоциация на модели объединения должна быть принадлежностью, 
# а записи, которые удаляются, являются записями объединений, а не соответствующими записями.
# 

class Author < ActiveRecord::Base
  has_many :book, class_name: '::Market::Model::Book'

  # has_many 
    # :book, 
    # class_name: '::Market::Model::Book'
    # foreign_key: :slide_id

  # ...

  def after_update_model params
    aff.destroy_all

    # ...

      aff << SlAf.new(slide_id: id, affiliate_name: name)



