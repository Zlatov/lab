# 1. Поля и свойства
# 2. Поведение
# 3. Связии
# 4. Дополнительные методы класса
# 5. Дополнительные методы инстанса
class Model < ApplicationRecord
  # 1. Поля и свойства
  # 2. Поведение
  # 3. Связии
  # 4. Дополнительные методы класса
  # 5. Дополнительные методы инстанса

  # Множественный первичный ключ
  self.primary_key = [:articul, :angar, :discount]

  # Kaminari (pagination)
  paginates_per 3

  # Полей в таблице до едрени фени, а при создании Клиента
  # определённой правовой формы используются только некоторые поля.
  # Принадлежность полей к созданию Клиента с формой:
  FIELD_SHOW_WITH_FORM = {
    form: %w(fiz yur ip),

    name: %w(yur),
    fio: %w(fiz ip),

    inn: %w(yur ip),
    kpp: %w(yur),
  }

  # Возвращает необходимо ли переданное поле для редактирования текущего клиента
  # (с текущей организационно правовой формой).
  # @param field_name [String|Symbol]
  # @return [Boolean]
  def field_show_with_form? field_name
    field_name = field_name.to_sym
    forms = FIELD_SHOW_WITH_FORM[field_name] || []
    return true if \
      self.class::FIELD_SHOW_WITH_FORM.keys.include?(field_name) &&
      self.class::FIELD_SHOW_WITH_FORM[field_name].include?(form)
    return false
  end

  # Что ж, прямо на лету эта модель может переобуться в другую БД
  def self.reconnect_to database_name
    current_spec = configurations['postgres']
    new_spec = current_spec.clone
    new_spec['database'] = database_name
    establish_connection(new_spec)
  end
end
