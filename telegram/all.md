# Telegram

Мессенджер (кроссплатформенная система мгновенного обмена сообщениями).

## Создание бота

Найти официального бота @BotFather в приложении, запустить его, найти команду
создания нового бота и следовать инструкциям 😁.

```sh
# Получить CHAT_ID.
# Следует найти id чата в ответе на запрос:
curl https://api.telegram.org/bot<BOT_TOKEN>/getUpdates

# Проверить
curl -X POST https://api.telegram.org/bot${{ env.TG_BOT_TOKEN }}/sendMessage \
  -d chat_id=${{ env.TG_CHAT_ID }} \
  -d parse_mode="Markdown" \
  -d text="*check* test" \
  -d disable_web_page_preview=true
```
