# GET-запросы в ruby

## Несоклько вариантов GET-запроса

```rb
# 1. Соединение открывается и закрывается автоматически. Подходит для теста или
# простого GET без заголовков и таймаутов.
response = Net::HTTP.get_response(uri)

# 2. То же самое, но вернётся сразу строка (тело ответа), без статуса и
# заголовков.
body = Net::HTTP.get(uri)

# 3. Явный http + request. Хорошо для настройки заголовков, авторизации и пр. Но
# соединение надо закрывать вручную, иначе будет "висящий" сокет.
http = Net::HTTP.new(uri.host, uri.port)
http.use_ssl = (uri.scheme == "https")

request = Net::HTTP::Get.new(uri)
request["Accept"] = "application/json"

response = http.request(request)
http.finish if http.active? # важно: соединение нужно закрыть вручную

# 4. Через Net::HTTP.start (с блоком, авто-закрытие). Соединение открывается и
# закрывается автоматически после блока. Самый "правильный" способ, если нужна
# настройка + безопасность.
response = Net::HTTP.start(
  uri.host, uri.port,
  use_ssl: uri.scheme == "https",
  read_timeout: 5
) do |http|
  request = Net::HTTP::Get.new(uri)
  request["Accept"] = "application/json"
  http.request(request)
end

# 5. "Последовательный", без блока, тоже Net::HTTP.start.
http = Net::HTTP.start(uri.host, uri.port, use_ssl: uri.scheme == "https", read_timeout: 5)

request = Net::HTTP::Get.new(uri)
request["Accept"] = "application/json"

response = http.request(request)
http.finish if http.active?

# 6. "Продвинутый" (таймауты, SSL verify)
http = Net::HTTP.new(uri.host, uri.port)
http.use_ssl = (uri.scheme == "https")
http.read_timeout = 5
http.open_timeout = 2
http.verify_mode = OpenSSL::SSL::VERIFY_PEER

request = Net::HTTP::Get.new(uri)
request["User-Agent"] = "RubyClient/1.0"

response = http.request(request)
http.finish if http.active?
```


## Итого, по GET запросу

Есть два "основных" варианта: `Net::HTTP.start` и `Net::HTTP.new`.
И два простых

`Net::HTTP.new` - "базовый", метод new принимает только два параметра, хост и
порт. После создания экземпляра можно настраивать, например `http.use_ssl =
(uri.scheme == "https")`. С блоком не умеет работать.

`Net::HTTP.start` - более "автоматизированный", может принимать настройки в
метод start и может настраиваться через экземпляр (как `Net::HTTP.new`). Если
получаем экземпляр и настраиваем - то уже не можем использовать блок, кторый
автоматически закрывает соединение.


## Как готовить URL для запроса

```rb
# 7. Управление параметрами в УРЛ (uri.query =...)
url = 'http://domain.com/some/path/file.ext?id=1&name=string#hash'
uri = URI.parse(url)
query = {
  id: 123,
  code: '000123',
  text: "asd\nzxc",
  url: 'https://русский-ёж.рф/статьи'
}
uri.query = URI.encode_www_form(query)
print 'uri: '.red; puts uri

# Чтобы добавить параметры в УРЛ (а не заменить)
existing_params = CGI.parse(uri.query.to_s)
new_params = existing_params.merge(
  "erid" => ["asd865sda5f43asdf4@#$%^&"],
  "text" => ["asd\nzxc"]
)
uri.query = URI.encode_www_form(new_params)

# Кодиррование
URI.encode_www_form_component("asd zxc") # кодирует один компонент
URI.encode_www_form({ id: 1, text: "asd zxc", tags: ['a','b'] }) # кодирует весь хэш (предпочтительнее -> кодирует ключи, собирает с &, обрабатывает массивы)
```
