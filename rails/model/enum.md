_app/model/user.rb_

```ruby
class User < ApplicationRecord

  enum legal_form: %i(fiz yur ip)
  enum status: {
    created: 0,
    confirmed: 1,
    agreed: 2,
    published: 3,
    closed: 4,
  }

  validates :form,
    presence: true,
    inclusion: { in: legal_forms.keys }

  def set_ui_name
    if legal_form == "fiz"
      @ui_name = fio
    else
      @ui_name = name
    end
  end

  # 
  # Лучше разместить эти методы в базовой модели
  # 
  # Если поле модели имеет перечисляемый тип (enum), то данный метод позволяет
  # перевести значения в базе данных в i18n-ое, в соответствии с конфигурацией.
  def self.human_enum_name(enum_name, enum_value)
    I18n.t("activerecord.attributes.#{model_name.i18n_key}.#{enum_name.to_s.pluralize}.#{enum_value}")
  end
  def human_enum_name(enum_name)
    self.class.human_enum_name enum_name, self[enum_name]
  end
end
```


```yml
ru:
  activerecord:
    attributes:
      market/model/client:
        legal_form: Организационно-правовая форма
        legal_forms:
          fiz: Физическое лицо
          yur: Юридическое лицо
          ip: Индивидуальный предприниматель
```
