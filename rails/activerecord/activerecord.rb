# 
# ```
# User.table_name
# User.column_names
# User.columns_hash
# ```
# 

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


# 
# JOIN
# 
# INNER JOIN
User.joins(:posts) # Только те пользователи у которых есть посты
# LEFT JOIN
User.left_outer_join(:posts) # Все пользователи, с учётом постов если они есть


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
# first_or_create не будет искать по заданным атрибутам! Неправильно: Foo.first_or_create(attributes).
# first_or_create полезно, если условия для поиска являются подмножеством хэш, используемого для создания:
Foo.where(something: value).first_or_create(attributes)
# Не подтверждено:
# first_or_createбудет использовать `ORDER BY id LIMIT 1`,
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
