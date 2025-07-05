# Hotwire

Общая философия + набор технологий от Basecamp/DHH. HOT = HTML Over The wire. То
есть: сервер отдает HTML, не JSON, а клиент (браузер) сам вставляет его в DOM.

Hotwire =
 Turbo +
 Stimulus (опционально)

__Turbo__ — основная библиотека **Hotwire**, она заменяет **UJS**.

**Turbo** реализует два механизма:

* __Turbo Frames__ — Обновляет часть страницы (внутри `<turbo-frame>`) после навигации/сабмита.
* __Turbo Streams__ — Сервер может отправить список «команд» по DOM: append, replace и т.п.

__UJS__ — старая технология из Rails 5/6

* Работает с remote: true
* Ожидает js.erb ответ
* Использует jQuery или чистый JS
