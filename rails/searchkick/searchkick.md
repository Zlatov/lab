
```rb
class User
  belongs_to :department

  # Добавить searchkick к моделям которые хотим искать.
  # 
  # С настройками:
  # word_middle - любая часть слова
  # suggest - поля из которых генерируются подсказки
  searchkick word_middle: [:email],
    suggest: [:email]

  # Какие данне индексировать
  def search_data
    {
      email: email,
      department_name: department.name,
      on_sale: sale_price.present?
    }
  end
```

```rb
class Admin::UsersController < Admin::ApplicationController
  def asd
    @users = Admin::User.search(params[:q], limit: 5, match: :word_middle)
  end
  def asd
    products = Product.search("peantu butta", suggest: true)
    # Подсказки которые можно вернуть.
    products.suggestions # ["peanut butter"]
  end
```
