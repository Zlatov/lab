after_initialize do |user|
  puts "You have initialized an object!"
end

after_find do |user|
  puts "You have found an object!"
end

# Список обратных вызовов при Создании
before_validation
after_validation
before_save
around_save
before_create
around_create
after_create
after_save
after_commit / after_rollback

# Список обратных вызовов при Обновлении
before_validation
after_validation
before_save
around_save
before_update
around_update
after_update
after_save
after_commit / after_rollback

# Список обратных вызовов при Уничтожении
before_destroy
around_destroy
after_destroy
after_commit / after_rollback




# Пердыдущее значение атрибута
# rails > 5.1)
attribute_before_last_save(:date)
date_before_last_save
# rails < 5.1
date_was




# 
# До сохранения
# 
will_save_change_to_attribute?(attr_name)
# Изменится ли этот атрибут при следующем сохранении?

attribute_change_to_be_saved(attr_name)
# Возвращает изменение атрибута, которое будет сохранено при следующем
# сохранении.

attribute_in_database(attr_name)
# Возвращает значение атрибута в базе данных, а не значение в памяти, которое
# будет сохранено при следующем сохранении записи.

changes_to_save
# Возвращает хэш, содержащий все изменения, которые будут сохранены при
# следующем сохранении.

has_changes_to_save?
# Будут ли при следующем вызове save сохраняться какие-либо изменения?

changed_attribute_names_to_save
# Возвращает массив имен любых атрибутов, которые изменятся при следующем
# сохранении записи.

attributes_in_database
# Возвращает хэш атрибутов, которые изменятся при следующем сохранении записи.
# Хэш-значения — это исходные значения атрибутов в базе данных (в отличие от
# значений в памяти, которые должны быть сохранены).


# 
# После сохранения
# 
saved_change_to_attribute?(attr_name)
saved_change_to_attribute(attr_name)
# Возвращает изменение атрибута после сохранения. Если атрибут был изменен,
# результатом будет массив, содержащий исходное значение и сохраненное
# значение.

attribute_before_last_save(attr_name)
# Возвращает исходное значение атрибута перед последним сохранением.

saved_changes
saved_changes.keys # список имён измененных полей

saved_changes.transform_values(&:first) # хэш со значениями до сохранения.
# Возвращает хэш, содержащий все только что сохраненные изменения.

saved_changes?
# Был ли вызов save, чтобы были внесены какие-либо изменения?
