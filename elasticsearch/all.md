# elasticsearch

## Установка

Скачать, установить и зпустить:


```bash
sudo systemctl start elasticsearch
sudo systemctl enable elasticsearch # запускался при старте сервера
```

__проверка__

```bash
curl -X GET "localhost:9200"
```
