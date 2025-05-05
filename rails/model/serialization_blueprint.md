## Красная таблетка rails-сериализационной реальности с Blueprint

```rb
render json: Blueprint.render_as_hash(obj)                  # Сериализует как объект, порядок ключей может быть перемешан
render json: Blueprint.render_as_json(obj)                  # Код `render json:` десериализует строку обратно в объект, затем снова сериализует
render plain: Blueprint.render_as_json(obj)                 # Возвращает именно строку JSON, ничего не трогает
render json: { raw: Blueprint.render_as_json(obj).to_json } # Хак: сохраняет строку как строку в JSON, без автоматического парса
```

## Немного философии

* Hash в Ruby 3+ сохраняет порядок.
* JSON в JavaScript — порядок не гарантирует.
* ActiveSupport может сделать вещи, которые ты не просил.
* Blueprint хорош, но Rails всё равно финально рулит сериализацией.
* Ты — последний бастион порядка и предсказуемости. 
