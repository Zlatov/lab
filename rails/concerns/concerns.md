
## Подключения концерна (модуля) двумя способами

```rb
before_save :normalize_blank_values

def normalize_blank_values
  attributes.each do |column, value|
    self[column].present? || self[column] = nil
  end
end
```

```rb
module NormalizeBlankValues
  extend ActiveSupport::Concern

  included do
    before_save :normalize_blank_values
  end

  def normalize_blank_values
    attributes.each do |column, value|
      self[column].present? || self[column] = nil
    end
  end

end

class User
  include NormalizeBlankValues
end
```
```rb
module NormalizeBlankValues
  extend ActiveSupport::Concern

  def normalize_blank_values
    attributes.each do |column, value|
      self[column].present? || self[column] = nil
    end
  end

  module ClassMethods
    def normalize_blank_values
      before_save :normalize_blank_values
    end
  end

end

ActiveRecord::Base.send(:include, NormalizeBlankValues)

class User
end

class Post
  normalize_blank_values

  # ...
end
```
