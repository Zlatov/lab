```rb
cookies[:user_name] = "david"

# В куках всегда стринга
cookies[:lat_lon] = JSON.generate([47.68, -122.37])

# На час
cookies[:login] = { value: "XJ-122", expires: 1.hour }

# До времени
cookies[:login] = { value: "XJ-122", expires: Time.utc(2020, 10, 15, 5) }

# Подольше (20 лет)
cookies.permanent[:login] = "XJ-122"

# «Подписанный» (только чтение) куки, который можно прочитать только методом signed
cookies.signed[:user_id] = current_user.id
cookies.signed[:name]

# Зашифрованый
cookies.encrypted[:discount] = 45
cookies.encrypted[:discount]

# Сочетание методов
cookies.signed.permanent[:login] = "XJ-122"

# Удаление
cookies.delete :user_name

# Для домена
cookies[:name] = {
  value: 'a yummy cookie',
  expires: 1.year,
  domain: 'domain.com'
}
cookies.delete(:name, domain: 'domain.com')
```
