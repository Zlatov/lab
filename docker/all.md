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

```bash
docker pull busybox # установить
docker images # установленные
docker run busybox # выполнить
docker ps # выполняемые
docker ps -a # выполненные
docker run -it busybox # войти
docker run -it busybox sh
docker rm $(docker ps -a -q -f status=exited) # удалить список выполненных докеров (контейнеров)
docker rmi hello-world # удалить образ докера
docker run -d -P --name <container_name> <image_name>
# 
# `-d` - detached, ну типа демон
# `-P` - открыть порты
# `--name <container_name>` - обозвать контейнер (должно быть уникально для каждого)
# 
docker port <container_id>|<container_name>
docker run -p 8888:80 <image_name> # Задать порт который будет переадресовываться на 80-внутренний
```

```
docker pull ubuntu:12.04
docker volume create portainer_data
docker run -d -p 9000:9000 --name portainer --restart always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer
```