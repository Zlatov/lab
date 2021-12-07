class Model < ApplicationRecord

  # Множественный первичный ключ
  self.primary_key = [:articul, :angar, :discount]

  # Kaminari (pagination)
  paginates_per 3

  # Позволяет указать что используется для создания URL-адреса объекта.
  def to_param
    slug
  end

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

  # Значение по умолчанию для поля
  # По умолчанию статья активна.
  def initialize params=nil
    super params
    if self.new_record?
      self.active = params&.[](:active).nil? ? true : params[:active]
    end
  end
  # или
  after_initialize do |article|
    if self.new_record? && self.active.nil?
      self.active = true
    end
  end
  # или
  after_initialize unless: :persisted? do |article|
    if self.active.nil?
      self.active = true
    end
  end
  # или
  after_initialize if: :new_record? do |article|
    if self.active.nil?
      self.active = true
    end
  end
end
