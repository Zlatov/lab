Model.table_name
Model.column_names
Model.columns_hash




# 
# Синтаксис логических выражений в SQL операторе WHERE переведён
# в синтаксис ActiveRecord следующим образом:
# 

# A || C:
Post.where(id: 1).or(Post.where(id: 2))

# A || !C:
Post.where(id: 1).or(Post.where.not(id: 2))

# (A && B) || C:
Post.where(a).where(b).or(Post.where(c))

# (A || B) && C:
Post.where(a).or(Post.where(b)).where(c)
Post.where(c).where(a).or(Post.where(b).where(c))

# 
# Примеры .where()
# 
Pt.joins(:total_sales).where('market_product_total_sales.is_sale' => true)
scoup1 = Offer.includes(:affiliates)
scope2 = scope1.where(affiliates: {id: affiliate.id}).or(
  scope1.where(affiliates: {id: nil})
)
scope3 = scope2.where(status: 'created', user_id: user.id).or(
  scope2.where(status: ['confirmed', 'agreed', 'published', 'closed'])
)




# 
# Использование транзакций
# 

# От базового класса
ActiveRecord::Base.transaction do
  david.withdrawal(100)
  mary.deposit(100)
end

# От модели
Account.transaction do
  # Вызываем save! с восклицательным знаком для
  # автоматического бросания ошибки при неверных запросах/данных запроса.
  balance.save!
  account.save!
end

# От экземпляра модели
balance.transaction do
  balance.save!
  # Откат по какой-либо бизнес логике:
  raise ActiveRecord::Rollback if account.sid.empty?
  account.save!
end

# При соединениях с разными базами данных:
Student.transaction do
  Course.transaction do
    course.enroll(student)
    student.units += course.units
  end
end

# Вложенные транзакции
# Родительская транзакция комитится даже если дочерняя ролбэчится.
# Чтобы поменять такое поведение необходимо добавить `requires_new: true`.
# В примере ниже Котори создастся только если Нему создастся.
User.transaction do
  User.create(username: 'Kotori')
  User.transaction(requires_new: true) do
    User.create(username: 'Nemu')
    raise ActiveRecord::Rollback
  end
end




# 
# find_or_create_by VS first_or_create
# 

# В принципе строки аналогичны:
Foo.find_or_create_by(attributes)
Foo.where(attributes).first_or_create
# 
# find_or_create_by - поисковый хэш равен хэшу создания что не всегда удобно
# first_or_create   - сначало найти с where, если нет, то создаёт другим хэшем
# 
# first_or_create не будет искать по заданным атрибутам! Неправильно: Foo.first_or_create(attributes).
# first_or_create полезно, если условия для поиска являются подмножеством хэш, используемого для создания:
Foo.where(something: value).first_or_create(attributes)
# Не подтверждено:
# first_or_create будет использовать `ORDER BY id LIMIT 1`,
# тогда как find_or_create_by просто будет использовать `LIMIT 1`




# 
# .order()
# 

User.order(:name)
# SELECT "users".* FROM "users" ORDER BY "users"."name" ASC
User.order(email: :desc)
# SELECT "users".* FROM "users" ORDER BY "users"."email" DESC
User.order(:name, email: :desc)
# SELECT "users".* FROM "users" ORDER BY "users"."name" ASC, "users"."email" DESC
User.order('name')
# SELECT "users".* FROM "users" ORDER BY name
User.order('name DESC')
# SELECT "users".* FROM "users" ORDER BY name DESC
User.order('name DESC, email')
# SELECT "users".* FROM "users" ORDER BY name DESC, email


# 
# Ассоциации
# 
# После find_by_sql можно разве что preload сделать.
@users = User.find_by_sql(
  <<-SQL
  SQL
)
ActiveRecord::Associations::Preloader.new.preload(@users, :company)
ActiveRecord::Associations::Preloader.new.preload(@users, [:company, :account])
ActiveRecord::Associations::Preloader.new.preload(@users, {company: :category})
ActiveRecord::Associations::Preloader.new.preload(@users, [{company: :category}, :account])
# Получить класс ассоциации (.klass) через связь:
@user.groups.klass
# Ассоциация с дополнительным методом (не путать со статическим условием
# ассоциации).
class Profile
  has_many :actions do
    def latest
      where("action_at <= ?", proxy_association.owner.timezone.now.to_date)
    end
  end
# Похоже на получение последник событий профиля в зависимости от данных профиля:
Profile.first.actions.latest




# 
# JOIN
# 

# INNER JOIN
User.joins(:posts) # Только те пользователи у которых есть посты
# LEFT JOIN
User.left_outer_join(:posts) # Все пользователи, с учётом постов если они есть




# 
# Способы подгрузки ассоциаций и фильтрация
# 

Model.joins(:relation).where()
Model.left_outer_join(:relation).where()
Model.includes(:relation).where().references(:relation)
Model.distinct.joins(:relation).where(relation: {field: :value})
Model.distinct.joins(:relation).where(relation: {field: :value}).preload(:relation, :relation2)

.includes().where().references().preload() # Подгружает ассоциации одним запросом, фильтрация накладывается на ассоциации даже с preload
.eager_load().where().preload()            # Подгружает ассоциации одним запросом, фильтрация накладывается на ассоциации даже с preload
.distinct.joins().where().preload()        # Подгружает ассоциации отдельными запросами, фильтрация НЕ накладывается на ассоциации

# .eager_load() равнозначен includes().references()

# .preload - отдельный подзапрос
class Person < ActiveRecord::Base
  has_many :notes
  # Ассоциация со статическим условием
  has_many :important_notes, -> { where(important: true) }, class_name: "Note"
end
Person.preload(:important_notes)
# Зато позволяет связывать с динамическим условием две модели. Однако обязателен
# вызов через `ActiveRecord::Associations::Preloader.new.preload` так как это
# позволяет избежать выборки `Price.where(currency_code: 'USD')` без условия на
# выбранные прежде основные модели, что сожрало бы память.
products = Product.all.to_a
ActiveRecord::Associations::Preloader.new.preload(
  products, :prices,
  # Вынуть именно USD цены из этой модели, с учётом выбранных products
  Price.where(currency_code: 'USD')
)
products.each do |product|
  product.prices.first.cents
end

# .eager_load - LEFT JOIN -  загружает ассоциации в одном запросе с
# использованием Left Outer Join, точно так же, как действует includes в
# сочетании с references.
class Person < ActiveRecord::Base
  has_many :notes
  has_many :important_notes, -> { where(important: true) }, class_name: "Note"
end
Person.eager_load(:important_notes)
# Попробовать:
Post.eager_load(:goods).joins("AND goods.user_id = 3").to_sql

# .includes - действует так же, как и preload, но в случае наличия условия по
# ассоциированной таблице переключается на создание единственного запроса с LEFT
# OUTER JOIN. Однако по каким-то причинам иногда необходимо форсировать
# применение такого подхода, в таких случаях необходимо использовать метод
# .references
User.includes(:posts).references(:posts).to_a

# .joins - INNER JOIN
User.joins(:posts)
# При этом, загружаются данные только из таблицы users. Кроме того, этот запрос
# может возвратить дублирующие друг друга записи (Избежать повторений можем с
# использованием distinct)
User.joins(:posts).select('distinct users.*').to_a




# 
# Limit
# 

Post.offset(10).limit(1)




# 
# Select
# 

# Нет необходимости в модель добавлять метод group_id:
users = ::User
  .select('users.* groups.id as group_id')
  .joins(:group)
users.first.group_id
