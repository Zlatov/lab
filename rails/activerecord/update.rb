exit

#  Method             Uses Default Accessor
#                             Saved to Database
#                                   Validations
#                                         Callbacks
#                                               Touches updated_at
#                                                     Readonly check
# | attribute=       | Yes  | No  | n/a | n/a | n/a | n/a | http://apidock.com/rails/ActiveRecord/AttributeMethods/Write/attribute%3D
# | write_attribute  | No   | No  | n/a | n/a | n/a | n/a | http://apidock.com/rails/ActiveRecord/AttributeMethods/Write/write_attribute
# | update_attribute | Yes  | Yes | No  | Yes | Yes | Yes | http://apidock.com/rails/ActiveRecord/Persistence/update_attribute
# | attributes=      | Yes  | No  | n/a | n/a | n/a | n/a | http://apidock.com/rails/ActiveRecord/AttributeAssignment/attributes%3D
# | update           | Yes  | Yes | Yes | Yes | Yes | Yes | http://apidock.com/rails/ActiveRecord/Persistence/update
# | update_column    | No   | Yes | No  | No  | No  | Yes | http://apidock.com/rails/ActiveRecord/Persistence/update_column
# | update_columns   | No   | Yes | No  | No  | No  | Yes | http://apidock.com/rails/ActiveRecord/Persistence/update_columns
# | User::update     | Yes  | Yes | Yes | Yes | Yes | Yes | http://apidock.com/rails/ActiveRecord/Relation/update
# | User::update_all | No   | Yes | No  | No  | No  | No  | http://apidock.com/rails/v4.0.2/ActiveRecord/Relation/update_all

# Обновить значение поля/полей у экземпляра
user.update_column(:last_request_at, Time.current)
user.update_columns(last_request_at: Time.current)

user.update(confirmed: true) # user.update!(confirmed: true)

user.confirmed = true
user.save                    # user.save!

# Обновить значение поля/полей у подмножества (возвращает количество затронутых строк)
User.where(filter: true).update_all(field: true)
