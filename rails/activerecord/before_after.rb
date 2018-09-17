# Создание объекта
before_validation
after_validation
before_save
around_save
before_create
around_create
after_create
after_save
after_commit/after_rollback

# Обновление объекта
before_validation
after_validation
before_save
around_save
before_update
around_update
after_update
after_save
after_commit/after_rollback

# Уничтожение объекта
before_destroy
around_destroy
after_destroy
after_commit/after_rollback


# destroy или delete
# destroy вызывает колбэки, delete — нет

# update ИЛИ save
# save и при создании и при обновлении, update только при обновлении
