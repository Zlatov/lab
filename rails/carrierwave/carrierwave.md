Добавляем гем в проект, добавим в _Gemfile_.

```ruby
gem 'carrierwave', '~> 2.0'
```

Обновим гемы и создадим загрузчик изображений.

```bash
bundle
rails g uploader Image
# Лучше добавить имя модели к которой загружаем
rails g uploader ProductImage
```

Добавим поле к модели

```bash
# Сгенерирует готовый к миграции код, однако можно задать default: {}...
rails g migration add_image_to_offer image:jsonb
rails db:migrate
```

Изменим поведение поля модели _app/models/\<model\>.rb_

```ruby

t.jsonb "images"
# Одно изображение на поле
mount_uploader :image, ImageUploader
# Много изображений на поле
mount_uploaders :images, ProductImageUploader
```

## Удаление файлов

Странно, что в 2021 году до сих пор симатическая проблема в удалении файлов, вот два способа удаления:

```rb
slide = Slide.last
slide.image = File.open('/path/to/file')
slide.save

slide.reload
slide.image
# => #<SlideUploader...>

# Превый способ
slide.remove_image! # Удалит файл и подготовит поле к обновлению при сохранении
slide.save

# Второй способ
slide.image.remove! # Удалит только файл
slide.update_column :image, nil # Сохранит сразу поле пустым

# Почему в первом способе к модели добавляются синтетические методы - имхо
# некрасиво.
# 
# Во втором способе я не нашел метод как можно обнулить поле, а сохранить
# отдельно через save.
```
