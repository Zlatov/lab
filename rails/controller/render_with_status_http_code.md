# Ключи статусов в rails для метода render

## 1xx: Informational (информационные)

| код | symbol | описание
| --- | --- | ---
| 100 | :continue | Continue / продолжай
| 101 | :switching_protocols | Switching Protocols / переключение протоколов
| 102 | :processing | Processing / идёт обработка
| 103 | :early_hints | Early Hints


## 2xx: Success (успешно)

| код | symbol | описание
| --- | --- | ---
| 200 | :ok | Ok / хорошо
| 201 | :created | Created / создано
| 202 | :accepted | Accepted / принято
| 203 | :non_authoritative_information | Non Authoritative Information / информация не авторитетна
| 204 | :no_content | No Content / нет содержимого
| 205 | :reset_content | Reset Content / сбросить содержимое
| 206 | :partial_content | Partial Content / частичное содержимое
| 207 | :multi_status | Multi Status / многостатусный
| 208 | :already_reported | Already Reported 
| 226 | :im_used | IM Used / использовано IM


## 3xx: Redirection (перенаправление)

| код | symbol | описание
| --- | --- | ---
| 300 | :multiple_choices | Multiple Choices Redirection / множество выборов
| 301 | :moved_permanently | Moved Permanently Redirection / перемещено навсегда
| 302 | :found | Found Redirection / найдено
| 303 | :see_other | See Other Redirection / смотреть другое
| 304 | :not_modified | Not Modified Redirection / не изменялось
| 305 | :use_proxy | Use Proxy Redirection / использовать прокси
| 306 | :reserved | Reserved Redirection
| 307 | :temporary_redirect | Temporary Redirect Redirection / временное перенаправление
| 308 | :permanent_redirect | Permanent Redirect Redirection / постоянное перенаправление


## 4xx: Client Error (ошибка клиента)

| код | symbol | описание
| --- | --- | ---
| 400 | :bad_request | Bad Request Client Error / плохой, неверный запрос (запрос не верен синтаксически, например, нехватка полей данных)
| 401 | :unauthorized | Unauthorized Client Error / не авторизован
| 402 | :payment_required | Payment Required Client Error / необходима оплата
| 403 | :forbidden | Forbidden Client Error / запрещено
| 404 | :not_found | Not Found Client Error / не найдено
| 405 | :method_not_allowed | Method Not Allowed Client Error / метод не поддерживается
| 406 | :not_acceptable | Not Acceptable Client Error / неприемлемо
| 407 | :proxy_authentication_required | Proxy Authentication Required Client Error / необходима аутентификация прокси
| 408 | :request_timeout | Request Timeout Client Error / истекло время ожидания
| 409 | :conflict | Conflict Client Error / конфликт
| 410 | :gone | Gone Client Error / удалён
| 411 | :length_required | Length Required Client Error / необходима длина
| 412 | :precondition_failed | Precondition Failed Client Error / условие ложно
| 413 | :request_entity_too_large | Request Entity Too Large Client Error / полезная нагрузка слишком велика
| 414 | :request_uri_too_long | Request Uri Too Long Client Error / URI слишком длинный
| 415 | :unsupported_media_type | Unsupported Media Type Client Error / неподдерживаемый тип данных
| 416 | :requested_range_not_satisfiable | Requested Range Not Satisfiable Client Error / диапазон не достижим
| 417 | :expectation_failed | Expectation Failed Client Error / ожидаение не удалось
| 418 | - | I’m a teapot / я&nbsp;— чайник
| 421 | :misdirected_request | Misdirected Request Client Error
| 422 | :unprocessable_entity | Unprocessable Entity Client Error / необрабатываемый экземпляр (запрос синтаксически верен, семантически - нет, данные не верны)
| 423 | :locked | Locked Client Error / заблокировано
| 424 | :failed_dependency | Failed Dependency Client Error / невыполненная зависимость
| 425 | :too_early | Too Early Client Error / неупорядоченный набор
| 426 | :upgrade_required | Upgrade Required Client Error / необходимо обновление
| 428 | :precondition_required | Precondition Required Client Error / необходимо предусловие
| 429 | :too_many_requests | Too Many Requests Client Error / слишком много запросов
| 431 | :request_header_fields_too_large | Request Header Fields Too Large Client Error / поля заголовка запроса слишком большие
| 451 | :unavailable_for_legal_reasons | Unavailable for Legal Reasons Client Error / недоступно по юридическим причинам


## 5xx: Server Error (ошибка сервера)

| код | symbol | описание
| --- | --- | ---
| 500 | :internal_server_error | Internal Server Error Server Error / внутренняя ошибка сервера
| 501 | :not_implemented | Not Implemented Server Error / не реализовано
| 502 | :bad_gateway | Bad Gateway Server Error / плохой, ошибочный шлюз
| 503 | :service_unavailable | Service Unavailable Server Error / сервис недоступен
| 504 | :gateway_timeout | Gateway Timeout Server Error / шлюз не отвечает
| 505 | :http_version_not_supported | Http Version Not Supported Server Error / версия HTTP не поддерживается
| 506 | :variant_also_negotiates | Variant Also Negotiates Server Error / вариант тоже проводит согласование
| 507 | :insufficient_storage | Insufficient Storage Server Error / переполнение хранилища
| 508 | :loop_detected | Loop Detected Server Error / обнаружено бесконечное перенаправление
| 509 | :bandwidth_limit_exceeded | Bandwidth Limit Exceeded Server Error / исчерпана пропускная ширина канала
| 510 | :not_extended | Not Extended Server Error / не расширено
| 511 | :network_authentication_required | Network Authentication Required Server Error / требуется сетевая аутентификация
