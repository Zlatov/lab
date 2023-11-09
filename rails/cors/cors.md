https://leopard.in.ua/2012/07/08/using-cors-with-rails
https://fetch.spec.whatwg.org/#cors-protocol-and-credentials
https://ru.stackoverflow.com/questions/1069331/%D0%A7%D1%82%D0%BE-%D1%82%D0%B0%D0%BA%D0%BE%D0%B5-access-control-allow-credentials
https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Access-Control-Allow-Credentials
https://stackoverflow.com/questions/63783088/using-cross-site-cookies-to-post-to-rails-api-from-chrome-extension

Правильный кросс-доменный запрос

```js
$.ajax({
  url: "http://some.another.domain/test",
  crossDomain: true,
  xhrFields: {
    withCredentials: true
  }
})
```

... обязательно будет содержать заголовк Origin (устанавливается браузером)

```
GET /test HTTP/1.1
Origin: http://some.another.domain
Host: some.another.domain
Accept-Language: en-US
Connection: keep-alive
User-Agent: Mozilla/5.0...
```

Чтобы правильно ответить необходимо установить заголовки

Access-Control-Allow-Origin (обязательно) - каким доменам разрешаем или звёздочка (всем).

Access-Control-Allow-Methods (обязательно) — список поддерживаемых HTTP-методов, разделенный запятыми. Обратите внимание: хотя предварительный запрос запрашивает разрешения только для одного метода HTTP, этот заголовок ответа может включать список всех поддерживаемых методов HTTP. Это полезно, поскольку предварительный ответ может быть кэширован, поэтому один предварительный ответ может содержать сведения о нескольких типах запросов.

Access-Control-Allow-Headers (требуется, если запрос имеет заголовок Access-Control-Request-Headers) — разделенный запятыми список поддерживаемых заголовков запроса. Как и заголовок Access-Control-Allow-Methods выше, здесь могут быть перечислены все заголовки, поддерживаемые сервером (а не только заголовки, запрошенные в предполетном запросе).

Access-Control-Allow-Credentials (необязательно) — по умолчанию файлы cookie не включаются в запросы CORS. Используйте этот заголовок, чтобы указать, что файлы cookie следует включать в запросы CORS. Единственное допустимое значение для этого заголовка — true (все строчные буквы).

Access-Control-Max-Age (необязательно) — выполнение предполетного запроса для каждого запроса становится дорогостоящим, поскольку браузер выполняет два запроса для каждого запроса клиента. Значение этого заголовка позволяет кэшировать предполетный ответ на указанное количество секунд.


```rb
class Api::BaseController < ApplicationController
  before_filter :set_headers

  private

  def set_headers
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Expose-Headers'] = 'ETag'
    headers['Access-Control-Allow-Methods'] = 'GET, POST, PATCH, PUT, DELETE, OPTIONS, HEAD'
    headers['Access-Control-Allow-Headers'] = '*,x-requested-with,Content-Type,If-Modified-Since,If-None-Match'
    headers['Access-Control-Max-Age'] = '86400'
  end
  # или
  def set_headers
    if request.headers["HTTP_ORIGIN"]
    # better way check origin
    # if request.headers["HTTP_ORIGIN"] && /^https?:\/\/(.*)\.some\.site\.com$/i.match(request.headers["HTTP_ORIGIN"])
      headers['Access-Control-Allow-Origin'] = request.headers["HTTP_ORIGIN"]
      headers['Access-Control-Expose-Headers'] = 'ETag'
      headers['Access-Control-Allow-Methods'] = 'GET, POST, PATCH, PUT, DELETE, OPTIONS, HEAD'
      headers['Access-Control-Allow-Headers'] = '*,x-requested-with,Content-Type,If-Modified-Since,If-None-Match,Auth-User-Token'
      headers['Access-Control-Max-Age'] = '86400'
      headers['Access-Control-Allow-Credentials'] = 'true'
    end
  end
end
```
