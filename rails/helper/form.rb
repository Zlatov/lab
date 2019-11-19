module FormHelper

  def field_errors model, field_name
    if model.errors.messages[field_name].is_a?(Array) && model.errors.messages[field_name].length > 0
      render partial: "market/desktop/partial/form/field_errors", locals: {
        model: model,
        field_name: field_name,
        messages: model.errors.messages[field_name],
      }
    end
  end

  # Добавляет css класс `required` к Лэйблу поля, если поле 
  # помечено как обязательное в модели:
  # ```
  # validates :name, presence: true
  # ```
  # Пример использования:
  # ```
  # <%= f.label :name, class: with_required(@user, :name, "") %>
  # ```
  # @param model_or_class [Class|<#Class>] - инстанс класса модели или класс модели;
  # @param field_name [Symbol] - инстанс модели или класс модели;
  # @param classes [String|nil] - первоначальные классы
  # @return [String]
  def with_required model_or_class, field_name, classes=nil
    _with_required = ''
    _with_required = classes if classes.is_a?(String) && classes.present?
    model_class = (model_or_class.class == Class) ? model_or_class : model_or_class.class
    if (
      model_class.validators_on(field_name).map(&:class)
        .include?(ActiveModel::Validations::PresenceValidator) ||
      model_class.validators_on(field_name).map(&:class)
        .include?(ActiveRecord::Validations::PresenceValidator)
    )
      _with_required += ' required'
    end
    _with_required
  end
end
