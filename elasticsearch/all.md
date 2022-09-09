# elasticsearch

## Установка

Там и java нужна определённой версии, в общем жесть - читать внимательно ставить только нужное:

1. Определиться с нужной версией (6 и 7 не совместимы, посмотреть какую юзает приложение!!!)

Проверка версии установленной версии:

```sh
curl -X GET "localhost:9200"
curl -XGET 'http://localhost:9200'
```

__Установка 6.8 версии:__

```sh
# Удаление 7 версии
sudo su
systemctl stop elasticsearch
systemctl status elasticsearch
systemctl disable elasticsearch
systemctl daemon-reload
apt --purge remove elasticsearch
rm -rf /var/lib/elasticsearch
rm /etc/apt/sources.list.d/elastic-7.x.list

cd
apt-get install openjdk-8-jdk
java -version
wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
apt install apt-transport-https
echo "deb https://artifacts.elastic.co/packages/6.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-6.x.list
apt update && apt install elasticsearch
mcedit /etc/elasticsearch/elasticsearch.yml
network.host: 0.0.0.0
systemctl enable elasticsearch
systemctl daemon-reload
systemctl status elasticsearch

```

__Установка 7 версии:__

Скачать, установить (
  deb: https://www.elastic.co/guide/en/elasticsearch/reference/current/deb.html
  ```sh
  sudo apt-get update && sudo apt-get install elasticsearch
  ```
  или
  ```sh
  wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-7.14.1-amd64.deb
  wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-7.14.1-amd64.deb.sha512
  shasum -a 512 -c elasticsearch-7.14.1-amd64.deb.sha512 
  sudo dpkg -i elasticsearch-7.14.1-amd64.deb

  sudo /bin/systemctl daemon-reload
  sudo /bin/systemctl enable elasticsearch.service

  sudo systemctl status elasticsearch
  ```
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

__проверка, версия__

```bash
curl http://localhost:9200/_cluster/health?pretty
curl -X GET "localhost:9200"
```
