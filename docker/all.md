# Docker

https://habr.com/ru/post/310460/


## Установка

```bash
sudo apt-get update
sudo apt install docker.io
```

```bash
sudo systemctl status docker
sudo systemctl start docker
sudo systemctl enable docker
```

```bash
sudo usermod -aG docker $(whoami)
# Затем перезагрузить компьютер нахер (релогин нахере помогает)!
sudo chmod 777 /var/run/docker.sock # 777 ??? TODO загуглить и понять кто тут придумал 777
```

```bash
docker --version
```


## Использование

__Образы__

```bash
docker pull <image> # скачать
docker images # скаченные
docker run <image> # запустить (создать) контейнер из образа
docker run -it <image> # запустить (создать) контейнер из образа и получить интерактивную консоль
docker run -it <image> sh # запустить (создать) контейнер из образа, получить интерактивную консоль и выполнить в ней команду sh
docker run --name <container> <image> # запустить (создать) контейнер из образа с заданным уникальным именем
docker run -p 8888:80 <image> # запустить (создать) контейнер из образа с пробросом порта
docker run -d -P <image> # `-d` - detached, типа демон; `-P` - открыть порты
docker rmi <image> # удалить образ
```

__Контейнеры__

```bash
docker ps # запущенные
docker ps -a # запущенные и оставновленные
docker start <container> # запустить остановленный контейнер
docker attach <container> # получить интерактивную консоль контейнера
docker commit -m "<tag>" <container> <image>:<tag> # создать новый образ из контейнера
docker push <image>:<tag> # запушить образ
docker rm <container>|<container_id> # удалить контейнер
docker rm $(docker ps -a -q -f status=exited) # удалить все оставновленные контейнеры
docker port <container_id>|<container> # посмотреть пробрасываемые порты
```

__Portainer - веб интерфейс докера__

```bash
docker volume create portainer_data
docker run -d -p 8000:8000 -p 9000:9000 --name=portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer
```
