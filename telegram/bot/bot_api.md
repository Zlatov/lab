
```sh
# Отправить сообщение
curl -X POST -H "Content-Type: application/json" -d "{\"chat_id\": \"<CHAT_ID>\", \"text\": \"Hi\"}" https://api.telegram.org/bot<BOT_TOKEN>/sendMessage
# или
curl -X POST https://api.telegram.org/bot$TG_BOT_TOKEN/sendMessage -d chat_id=$TG_CHAT_ID -d parse_mode="Markdown" -d text="test"
# Важно: если указан флаг parse_mode="Markdown", то сообщение должно быть с
# абсолютно валидным синтаксисом. Если сообщение динамическое (часть текста из
# другого сервиса/приложения) - нужно быть уверенным что составляющие части
# либо не содержат markdown разметку либо содержат валидную, что очень редко.
```
