class Parent
  self.primary_key = 'sid'
class Child
  belongs_to :parent,
    foreign_key: :parent_sid,
    primary_key: :sid
# один-к-одному, содержит FK,
# один экземпляр модели "принадлежит" одному экземпляру другой модели.

class User
  has_one :account,
    foreign_key: :user_sid,
    primary_key: :sid
# один-к-одному, ID совпадает с FK принадлежащей модели,
# один экземпляр модели имеет или обладает одним экземпляром другой модели.

class User
  has_many :orders
# один-ко-многим, ID совпадает с FK принадлежащей модели,
# один экземпляр модели имеет или обладает несколькими экземплярами другой модели.

class User
  self.primary_key = 'sid'
  has_and_belongs_to_many :groups,
    join_table: :market_us_gr, # имя смежной таблицы
    foreign_key: :user_sid, # FK в смежной таблице для этого класса
    association_foreign_key: :group_id # FK в смежной таблице для связываемого класса
class Group
  has_and_belongs_to_many :users,
    join_table: :market_us_gr,
    foreign_key: :group_id,
    association_foreign_key: :user_sid
# многие-ко-многим, без промежуточной модели.
# каждый пользователь состоит во многих группах, и каждая группа имеет много пользователей
# НЕ ПОДДЕРЖИВАЕТ опциею :dependent

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




