
# Серверы

## VDS и VPS

VDS (Virtual Dedicated Server) или VPS (Virtual Private Server) — это хостинг-услуга, где пользователю предоставляется виртуальный сервер с максимальными привилегиями.

Бытует мнение, что термины обозначают виртуальные серверы с различными типами виртуализации: VPS обозначает виртуализацию на уровне операционной системы, VDS — аппаратную виртуализацию. На самом деле, оба термина появились и развивались параллельно, и обозначают одно и то же: виртуальный выделенный сервер, запущенный на базе физического.


## OpenVZ и KVM

Технология OpenVZ базируется на ядре ОС Linux и позволяет на одном физическом сервере создавать и запускать изолированные друг от друга копии операционной системы — так называемые «виртуальные частные серверы» (Virtual Private Servers, VPS) или «виртуальные среды» (Virtual Environments, VE). Данная технология отличается высокой производительностью, простотой использования и легкостью управления сервером.

KVM (Kernel-based Virtual Machine) – технология аппаратной виртуализации, позволяющая создать на хост-машине полный виртуальный аналог реального физического сервера. Каждому такому серверу выделяется своя область в оперативной памяти и пространство на жестком диске, собственная сетевая карта, что повышает общую надежность работы такого сервера. Фактически технология KVM позволяет создать полностью изолированный от «соседей» виртуальный сервер с собственным ядром ОС, который пользователь может настраивать и модифицировать под собственные нужды практически без ограничений. Возможна установка любой операционной системы: Linux, FreeBSD, Windows и даже собственного образа. Вместе с тем, изменение ресурсов сервера невозможно – если ваш проект «вырастет» из первоначально выбранного тарифа, для него нужно будет заказать более производительный виртуальный сервер по соответствующему тарифу и перенести на него все данные (как в случае с настоящим выделенным сервером).

fale2ban

https://eboundhost.com/
https://vscale.io/ru/
https://www.ovh.ie/
https://ru.hetzner.com/
https://www.vultr.com/
https://www.ihor.ru

## Расширение SWAP файла

```bash
sudo fallocate -l 1G /swapfile
# Или:
sudo dd if=/dev/zero of=/swapfile bs=1024 count=1048576

sudo chmod 600 /swapfile
#Use the mkswap utility to set up a Linux swap area on the file:
sudo mkswap /swapfile
#Activate the swap file using the following command:
sudo swapon /swapfile
#To make the change permanent open the /etc/fstab file:
sudo nano /etc/fstab
#and paste the following line:
/etc/fstab
/swapfile swap swap defaults 0 0
#Verify that the swap is active by using either the swapon or the free command as shown below:
sudo swapon --show
#NAME      TYPE  SIZE   USED PRIO
#/swapfile file 1024M 507.4M   -1
sudo free -h
#              total        used        free      shared  buff/cache   available
#Mem:           488M        158M         83M        2.3M        246M        217M
#Swap:          1.0G        506M        517M
sudo reboot
```
