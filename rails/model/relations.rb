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

# 
# has_many options:
# 
# :class_name
# :foreign_key - имя внешнего ключа (_id).
# :foreign_type - имя столбеца, используемого для хранения типа связанного объекта, если это полиморфная ассоциация.
# :primary_key - имя первичного ключа (id).
# :counter_cache -
# :as -
# :through -
# :source -
# :source_type -
# :validate -
# :autosave -
# :inverse_of -
# :extend -
# 

# 
# Пример has_many has_many
# 

class Tovar

  has_many :video_cards_rels,
    class_name: '::TovarsVideoCard',
    foreign_key: :tovar_articul,
    primary_key: :articul

  has_many :video_cards,
    class_name: '::VideoCard',
    through: :video_cards_rels

class TovarsVideoCard

  belongs_to :video_card,
    class_name: '::VideoCard',
    foreign_key: :video_id,
    primary_key: :id

  belongs_to :tovar,
    class_name: '::Tovar',
    foreign_key: :tovar_articul,
    primary_key: :articul

class VideoCard

  has_many :tovars_rels,
    class_name: '::TovarsVideoCard',
    foreign_key: :video_id,
    primary_key: :id

# 
# Пример has_and_belongs_to_many
# 

class User
  self.primary_key = 'sid'
  has_and_belongs_to_many :groups,
    class_name: "Market::Model::Add::Group", # имя связываемой таблицы
    join_table: :market_us_gr, # имя смежной таблицы
    foreign_key: :user_sid, # FK в смежной таблице для этого класса
    association_foreign_key: :group_id # FK в смежной таблице для связываемого класса
class Group
  has_and_belongs_to_many :users,
    class_name: "Market::Model::Main::User",
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

# 
# Как после обновления модели обновить пришедшие связи
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

# 
# Как в консоли добавить связи
# 

# Один ко многим
post = Post.find
post.comments << Comment.create! text: 'asd'
post.comments = [
  Comment.new(post_id: post.id, text: 'qwe')
]
post.comment_ids = [1, 7, 15]

# 
# Дополнительный фильтр на связь, которая может отдавать множестов
# 
  has_many :comments,
    through: :comment_posts do
      def by_angar angar_code
        where angar: angar_code
      end
    end
