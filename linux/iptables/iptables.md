# iptables

```sh
# Показать правила
iptables -S INPUT

# Показать открытые (типа) порты
sudo ss -ltn

# Добавить правило открывающее порт 2376 (соединение через ssl портейнера с docker)
iptables -I INPUT -p tcp -m tcp --dport 2376 -j ACCEPT
# Добавить правило открывающее порт 5432 для обращения с подсети докера 172.16.0.0/12
iptables -I INPUT -p tcp -s 172.16.0.0/12 --dport 5432 -j ACCEPT
# Чтобы удалить правило:
iptables -D INPUT -p tcp -s 172.16.0.0/12 --dport 5432 -j ACCEPT
# Удалить правило по номеру:
iptables -L INPUT --line-numbers
iptables -D INPUT 1

# Сохранить чтобы правила остались после перезагрузки:
service iptables save
```
