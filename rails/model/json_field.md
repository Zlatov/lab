```rb
class Affiliate < ApplicationRecord
  serialize :working_hours, WorkingHoursSerializer
end

class Affiliate::WorkingHoursSerializer
  def self.dump(value)
    # Когда параметры на сохранения приходят из формы, по стандарту они приходят
    # в виде хэш: {"0"=>{"holiday"=>"true"},"1"=>{"holiday"=>"false"}}
    value = value.values if value.is_a? Hash
    # Затем, видимо, чтобы привести к общему виду данные повторно прогоняются
    # через метод load перед сохранением и мы получаем OpenStruct, а хотим
    # хранить json.
    value = value.map(&:to_h).map(&:stringify_keys) if value.is_a? Array
    # Параметр holiday не обязателен, но мы хотим чтобы он всегда был boolean.
    value = value.map do |v|
      v['holiday'] = v['holiday'] == 'true' || v['holiday'] == true
      v
    end
    # Если в форме поставить галку на удаление, то забываем просто одну «строку
    # данных».
    value = value.reject{|working_hour| working_hour['_destroy'].present?}

    value
  end

  def self.load(value)
    return [] if value.blank?

    value.map do |working_hour|
      # Хочу, чтобы поле 'holiday' всегда было установлено, даже если дорбавили
      # из консоли данные без поля.
      working_hour['holiday'] = working_hour['holiday'] == true
      OpenStruct.new(working_hour)
    end
  end
end

```

```rb
Affiliate.find(1).working_hours
# [#<OpenStruct days="пн", hours="8:00 - 20:00", holiday=false>, #<OpenStruct days="пн-вс", hours="8:00 - 18:00", holiday=false>]
Affiliate.find(1).attributes_before_type_cast['working_hours']
# [{"days":"пн","hours":"8:00 - 20:00","holiday":false},{"days":"пн-вс","hours":"8:00 - 18:00","holiday":false}]
Affiliate.find(1).update_columns(working_hours: [{days:"1",hours:"8-20",holiday:false},{days:"2",hours:"8-18",holiday:true},{days:"3",hours:"8-9"}])
```
