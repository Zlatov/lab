# Docker

https://habr.com/ru/post/310460/


## Установка

```bash
sudo apt-get update
sudo apt install docker.io

# Для локальной машины можно:
sudo yum check-update
curl -fsSL https://get.docker.com/ | sh

# Для продакшн
sudo yum install -y yum-utils
sudo yum-config-manager \
  --add-repo \
  https://download.docker.com/linux/centos/docker-ce.repo
sudo yum install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo systemctl start docker
sudo docker run hello-world
sudo usermod -a -G docker deployer  
```

```bash
systemctl --no-page status docker
sudo systemctl start docker
sudo systemctl enable docker
```

```bash
# Добавить текущего пользователя в группу докера
sudo usermod -aG docker $(whoami)
sudo chmod 666 /var/run/docker.sock
```

```bash
docker --version
```


## Установка docker-compose

```sh
# Откуда брать ссылку для скачивания docker-compose: https://github.com/docker/compose/releases
# Какую именно сборку скачивать, выполнить:
echo "$(uname -s)-$(uname -m)"
sudo su
curl -SL https://github.com/docker/compose/releases/download/v2.15.1/docker-compose-linux-x86_64 -o /usr/local/bin/docker-compose
ls -la /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose # Если необходимо!
^D
docker-compose --version
docker-compose top

# Может потребоваться добавить пользователя в группу docker
sudo usermod -a -G docker deployer
```


## Использование

__Образы__

```bash
docker pull {image} # скачать
docker images # скаченные
docker run {image} # запустить (создать) контейнер из образа
docker run -it {image} # запустить (создать) контейнер из образа и получить интерактивную консоль
docker run -it {image} sh # запустить (создать) контейнер из образа, получить интерактивную консоль и выполнить в ней команду sh
docker run --name {container} {image} # запустить (создать) контейнер из образа с заданным уникальным именем
docker run -p 8888:80 {image} # запустить (создать) контейнер из образа с пробросом порта
docker run -d -P {image} # `-d` - detached, типа демон; `-P` - открыть порты
docker rmi {image} # удалить образ
docker run -v /home/username/dir:/mnt # запустить (создать) контейнер с пробросом пути системы в /mnt контейнера, для копирования файлов и др.
```

__Контейнеры__

```bash
docker ps # запущенные
docker ps -a # запущенные и оставновленные
docker start {container} # запустить остановленный контейнер
docker stop {container} # остановить контейнер
docker stop $(docker ps -q) # остановить все запущенные контейнеры
docker attach {container} # получить интерактивную консоль контейнера
# [Ctrl+p, Ctrl+q] - для выхода из консоли, незавершая текущий процесс
docker commit -m "{tag}" {container} {image}:{tag} # создать новый образ из контейнера
docker push {image}:{tag} # запушить образ
docker rm {container}|{container_id} # удалить контейнер
docker rm $(docker ps -a -q -f status=exited) # удалить все оставновленные контейнеры
# или
docker system prune
docker port {container_id}|{container} # посмотреть пробрасываемые порты
docker exec -it zenonline bash -c 'cd /app && ls -lah' # отправка команды в контейнер (запущенный!)
```

__Тома (volume) - пробросы каталогов__

```bash
docker volume ls # список томов
docker volume create # создать том
docker volume inspect # инфа тома
docker volume rm # удалить
docker volume prune # удалить все неиспользуемые
```

__Система докера__

```bash
docker system df # использование диска
docker system events # в режиме реального времени наблюдать за логом сервера докера
docker system info # о программе (расширенная инфа: версия, текущий пользователь...)
docker system prune # удалить неиспользуемые контейнеры и другое...
```

__Portainer - веб интерфейс докера__

```bash
docker volume create portainer_data
docker run -d -p 8000:8000 -p 9000:9000 --name=portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer
```
Настройка SSL для доступа к удалённому docker в portainer:

https://docs.docker.com/engine/security/protect-access/

и копируем файлы на локальную машину: ca.pem cert.pem key.pem

```sh
# /etc/systemd/system/docker.service.d/10-machine.conf
# Запуск докер с SSL ключами
[Service]
ExecStart=
ExecStart=/usr/bin/dockerd -H tcp://0.0.0.0:2376 -H unix:///var/run/docker.sock --storage-driver overlay2 --tlsverify --tlscacert /etc/docker/ssl/ca.pem --tlscert /etc/docker/ssl/server-cert.pem --tlskey /etc/docker/ssl/server-key.pem --label provider=generic
# systemctl daemon-reload
# systemctl restart docker
```

Настройка подключения портейнера к серверу:

Endpoints -> Directly connect to the Docker API:
Endpoint URL: domain:2376

Может понадобится открыть порт через iptables

```sh
iptables -I INPUT -p tcp -m tcp --dport 2376 -j ACCEPT
```


## Использование docker compose

```sh
docker compose config # Проверить конфигурацию
docker compose up --build # собираем контейнеры в первый раз
docker compose up --build --no-start # собираем но без запуска
docker compose down -v --remove-orphans # удалить контейнеры с томами (опция -v) и контейнеры сервиса не указанные в файле docker-compose.yml
docker compose stop # все контейнеры...
docker compose start

docker exec -it pg bash

docker-compose rm store_db # Удалить контейнер store_db (удалит все данные если не в volumes!!!)
# удатлить тут: http://localhost:9000/#/volumes И:
sudo rm -rf ./volumes/ # чтобы наверняка удалить данные с удалением контейнеров )))
docker volume rm ...

docker-compose up --build --no-start
# И вообще
docker-compose --help
docker-compose command --help
# docker-compose run store_db bash # (((

# Зааттачиться к контейнеру в bash/sh
docker-compose exec store_ruby sh
# Установить в контейнере bash
apk add --no-cache bash
docker-compose exec store_ruby bash
# Закомитить изменения контейнера store_ruby в image store_ruby
docker commit store_ruby store_ruby
# Добавить тег с префиксом пользователя hub.docker.com
docker tag store_ruby zlatov/store_ruby
# Сохранить изображение
docker push zlatov/store_ruby

# Запустить рельсовую команду внутри контейнера
# если контейнер запущен, то можно exec:
docker-compose exec store_ruby bundle exec rails db:seed
# если контейнер остановлен - необходимо запустить не основной с удалением:
docker-compose run --rm store_ruby bundle exec rails db:seed
```


## TODO Запуск контейнера не из под root

https://medium.com/redbubble/running-a-docker-container-as-a-non-root-user-7d2e00f8ee15


## Хранение изображений на GitHub

```sh
docker login ghcr.io
docker push ghcr.io/zlatov/asd...:latest
```

## Как затянуть такое же изображение какое было затянуто когда-то по латест

```sh
# Команда
docker image inspect {image_name_or_id}
# вернёт Id, но нужно использовать RepoDigests вместо него:
# "Id": "sha256:580c0e4e98b06d258754cf28c55f21a6fa0dc386e6fe0bf67e453c3642de9b8b",
# "RepoTags": [
#     "portainer/portainer:latest"
# ],
# "RepoDigests": [
#     "portainer/portainer@sha256:fb45b43738646048a0a0cc74fcee2865b69efde857e710126084ee5de9be0f3f"
# ],

docker pull portainer/portainer@sha256:fb45b43738646048a0a0cc74fcee2865b69efde857e710126084ee5de9be0f3f
```
