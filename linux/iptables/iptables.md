# iptables

```sh
# Показать правила
iptables -S INPUT

# Показать открытые (типа) порты
sudo ss -ltn

# Добавить правило открывающее порт 2376 (соединение через ssl портейнера с docker)
iptables -I INPUT -p tcp -m tcp --dport 2376 -j ACCEPT

service iptables save
```
