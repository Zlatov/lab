# Обновить значение поля/полей у экземпляра
user.update_columns(last_request_at: Time.current)

# Обновить значение поля/полей у подмножества
User.where(filter: true).update_all(field: true)
