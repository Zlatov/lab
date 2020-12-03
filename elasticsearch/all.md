# elasticsearch

## Установка

Там и java нужна определённой версии, в общем жесть - читать внимательно ставить только нужное:

Скачать, установить (
  deb: https://www.elastic.co/guide/en/elasticsearch/reference/current/deb.html
  sudo apt-get update && sudo apt-get install elasticsearch
) и зпустить:

Отредактируйте `/etc/elasticsearch/elasticsearch.yml` и добавьте следующую строку:
```bash
network.host: 0.0.0.0
```

Если будет нужно!!!:
```bash
# mcedit /etc/default/elasticsearch
JAVA_HOME=/usr/bin/java
```


При переустановке (даунгрейде) эластика позаботится об удаленнии вручную каталога `/var/lib/elasticsearch`, а то можно потерять пару часов на этот бред. Твари.


```bash
sudo systemctl start elasticsearch
sudo systemctl enable elasticsearch # запускался при старте сервера
sudo systemctl status elasticsearch
```

__проверка__

```bash
curl -X GET "localhost:9200"
```
