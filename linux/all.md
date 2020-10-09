что такое nat
как работает proxy
как преобразуется домен в ip
как работает http протокол


## Режим восстановления

Как переключить файловую систему в режим чтения записи (file system in recovery mode to read-write mode): `mount -o rw,remount /`


## synaptic - менеджер пакетов


## форматирование флешки

проверим наличие нашего Flash-накопителя:
```
fdisk -l
```

Выведет информацию о всех подключённых накопителях и их разделах. Обычно sda — это диск на котором установлена ОС, значит нас интересуют sdb, sdc и т.д. Зная объем своей флешки, в моем случае 4gb, я увидел следующее:

```
Disk /dev/sdb: 3,8 GiB, 4055885824 bytes, 1980413 sectors
Units: sectors of 1 * 2048 = 2048 bytes
Sector size (logical/physical): 2048 bytes / 2048 bytes
I/O size (minimum/optimal): 2048 bytes / 2048 bytes
Disklabel type: dos
Disk identifier: 0x6f20736b
Устр-во    Загрузочный Start Конец    Blocks   Id  System
/dev/sdb1  *           512   1980412  3959802  7   HPFS/NTFS/exFAT
/dev/sdb1 - это и есть та самая флешка с которой будем работать.
```

Нужно проверить примонтирована ли флешка, сделать это можно командой `df -h`:
```
df -h /dev/sdb1
```

Сама по себе, команда df -h, выводит весь список примонтированных устройств.

Если флешка примонтирована, нужно отмонтировать:

```
umount /dev/sdb1
```

Теперь можно форматировать, форматировать будем в ntfs командой mkfs:

```
mkfs.ntfs -L name /dev/sdb1
```
`mkfs` — комада для форматирования.
`ntfs` — файловая система.
`-L` — аргумент, позволяющий присвоить имя нашей флешки (недоступен для fat32).
`name` — имя (метка) нашей флешки.
`/dev/sdb1` — путь к флешки.

Команды для форматирования в другие файловые системы предназначенные для Flash-накопителей:

`mkfs.ntfs` - NTFS

`mkfs.msdos` - MSDOS

`mkfs.vfat` - VFAT (расширенная FAT32)


## Console

### show

`export PS1='$(whoami)@$(hostname):$(pwd)$ '`

or

`export PS1='$(whoami)@$(hostname):$(pwd)'`


## Обновления, установки...

### Upgrade mysql 5.5 to 5.6 ubuntu 14.04

Не сработало?:

```
sudo apt-get update
sudo apt-get upgrade
sudo apt-get install mysql-server-5.6
```

Тогда вместо `sudo apt-get upgrade` попробовать `sudo apt-get dist-upgrade`.

А вместо `sudo apt-get install mysql-server-5.6` вообще выполнить список нижеперечисленных:


1. Делаем бэкап

```
mysqldump --lock-all-tables -u root -p --all-databases > dump.sql
```

2. Удаляем пакеты (оставляем конфиги). Чтобы удалить и настройки нужно использовать `sudo apt-get purge somePackage`

```
sudo apt-get remove mysql-server
sudo apt-get autoremove
```

```
sudo apt-get remove mysql-client
sudo apt-get autoremove
```

* Устанавливаем то, что хотели

```
sudo apt-get install mysql-client-5.6 mysql-client-core-5.6
sudo apt-get install mysql-server-5.6
```

* Восстанавливаем бэкап

```
mysql -u root -p < dump.sql
```
</ol>


## Переменные окружения

(переменные среды, environment variable)

Посмотреть пути `echo $PATH`

### Добавить в $PATH свою директорию (создать свои консольные команды)

```bash
mkdir mkdir -p ~/bin
touch ~/.profile
chmod 754 ~/.profile
nano ~/.profile
```

```
#!/bin/bash
if [ -d &quot;$HOME/bin&quot; ]
    then
        PATH=&quot;$HOME/bin:$PATH&quot;
fi

```

Незабыть выйти/зайти ssh (ну или новое окно терминала открыть).


python
>>> import paramiko
>>> print paramiko.__version__
1.12.0

python get-pip.py --proxy="10.192.0.3:3128"
pip --proxy proxy.newstar.ru:3128 install --upgrade paramiko==1.15.2

which pip
/usr/local/bin/pip uninstall pip  
apt-get remove python-pip  
apt-get install python-pip

pip --proxy proxy.newstar.ru:3128 install --upgrade pip

/usr/local/bin/pip --proxy proxy.newstar.ru:3128 install --upgrade paramiko==1.15.2


    <a href="http://bashrcgenerator.com/">http://bashrcgenerator.com/</a>

https://www.opennet.ru/docs/RUS/bash_scripting_guide/x13621.html https://www.midnight-commander.org/wiki/ru/doc/editor/hotkeys http://superuser.com/questions/461452/is-there-a-way-to-change-shortcuts-in-midnight-commander http://ss64.com/bash/touch.html http://askubuntu.com/questions/161249/bashrc-not-executed-when-opening-new-terminal https://www.opennet.ru/tips/1408_bash_shell.shtml

```bash
#!/bin/bash
#export PS1="\[\033[38;5;11m\]\u\[$(tput sgr0)\]\[\033[38;5;15m\]@\h:\[$(tput sgr0)\]\[\033[38;5;6m\][\w]:\[$(tput sgr0)\]\[\033[38;5;15m\] \[$(tput sgr0)\]"
export PS1='$(whoami)@$(hostname):$(pwd)$ '
if [[ -n $SSH_CONNECTION ]] ; then
    echo "I'm logged in remotely"
fi
```

## Параметры системы

### Отключить Связки ключей

#### Только для одного приложения (Google Chrome)

в ярлык добавить  `--password-store=basic`

```
/usr/bin/google-chrome-stable %U --password-store=basic
```

#### Отключить полностью

__Win__ -> `Пароли и ключи` -> __ПКМ__ на <q>Связка ключей по умолчанию</q> -> <q>Изменить пароль</q> -> Ввести старый, новый оставить пустым, перезайти пользователем.

### Чувствительность мыши

```

$ xinput --list --short
⎡ Virtual core pointer                      id=2    [master pointer  (3)]
⎜   ↳ Virtual core XTEST pointer                id=4    [slave  pointer  (2)]
⎜   ↳ Logitech Gaming Mouse G502                id=8    [slave  pointer  (2)]
⎜   ↳ Logitech Gaming Mouse G502                id=9    [slave  pointer  (2)]
⎣ Virtual core keyboard                     id=3    [master keyboard (2)]
    ↳ Virtual core XTEST keyboard               id=5    [slave  keyboard (3)]
    ↳ Power Button                              id=6    [slave  keyboard (3)]
    ↳ Power Button                              id=7    [slave  keyboard (3)]
    ↳ AT Translated Set 2 keyboard              id=10   [slave  keyboard (3)]
$ xinput --list-props 8
Device 'Logitech Gaming Mouse G502':
Device Enabled (142):   1
Coordinate Transformation Matrix (144): 1.000000, 0.000000, 0.000000, 0.000000, 1.000000, 0.000000, 0.000000, 0.000000, 1.000000
Device Accel Profile (274): 0
Device Accel Constant Deceleration (275):   1.500000
Device Accel Adaptive Deceleration (276):   1.700000
Device Accel Velocity Scaling (277):    10.000000
Device Product ID (263):    1133, 49277
Device Node (264):  "/dev/input/event3"
Evdev Axis Inversion (278): 0, 0
Evdev Axes Swap (280):  0
Axis Labels (281):  "Rel X" (152), "Rel Y" (153), "Rel Horiz Wheel" (272), "Rel Vert Wheel" (273)
Button Labels (282):    "Button Left" (145), "Button Middle" (146), "Button Right" (147), "Button Wheel Up" (148), "Button Wheel Down" (149), "Button Horiz Wheel Left" (150), "Button Horiz Wheel Right" (151), "Button Side" (267), "Button Extra" (268), "Button Forward" (269), "Button Back" (270), "Button Task" (271), "Button Unknown" (266), "Button Unknown" (266), "Button Unknown" (266), "Button Unknown" (266), "Button Unknown" (266), "Button Unknown" (266), "Button Unknown" (266), "Button Unknown" (266), "Button Unknown" (266), "Button Unknown" (266), "Button Unknown" (266), "Button Unknown" (266)
Evdev Scrolling Distance (283): 1, 1, 1
Evdev Middle Button Emulation (284):    1
Evdev Middle Button Timeout (285):  50
Evdev Third Button Emulation (286): 0
Evdev Third Button Emulation Timeout (287): 1000
Evdev Third Button Emulation Button (288):  3
Evdev Third Button Emulation Threshold (289):   20
Evdev Wheel Emulation (290):    0
Evdev Wheel Emulation Axes (291):   0, 0, 4, 5
Evdev Wheel Emulation Inertia (292):    10
Evdev Wheel Emulation Timeout (293):    200
Evdev Wheel Emulation Button (294): 4
Evdev Drag Lock Buttons (295):  0
$ xinput --set-prop 8 "Device Accel Constant Deceleration" 1.7
```

## Дополнительное ПО

### Incscape

Неплохой редактор векторных изображений.

### FreeRdp

```
xfreerdp /cert-ignore –no-nego /u:administrator /p:123 /v:192.168.172.129 /port:2179 /vmconnect:8021D293-FA6F-4CB5-AFD2-2499936D0949
```

```
xfreerdp --version
```

case of 1.0.2 the "old" command line needs to be used. That would be something like xfreerdp -u username servername:port - server name and port must be the last argument.

```
xfreerdp -u username servername:port
```


### gpick

— улучшенный инструмент выбора цвета, позволяющий выбирать цвета из любых мест экрана

### VirtualBox

Отключить захват клавиатуры чтобы быстро переключаться с поммощью __Alt + Tab__ из винды в линукс, а не по окнам винды:

<q>Файл</q> → <q>Настройки</q> → <q>Ввод</q> → <q>Автозахват клавиатуры</q> (убрать галку)

### Terminal

* Размер терминала по умолчанию - сделай под себя
* Убрать - Включить клавишу для доступа в меню (F10 по умолчанию) - для удобной работы в терминаля с утилитой mc


### Shutter (PrintScreen as PicPick)

* Set to run this application with the system.
* Customize hotkey printskrin to run the application in selection screen area mode.


### pv (Pipe Viewer)

If you're just importing from a dump file from the CLI on \*nix, e.g.

```
mysql -uxxx -pxxx dbname < /sqlfile.sql
```

then first install pipe viewer on your OS then try something like this:

```
pv sqlfile.sql | mysql -uxxx -pxxxx dbname
```

which will show a progress bar as the program runs.


## Дополнительно

### Знак рубля не отображается

Загуглить, скачать, установить бесплатный шрифт Symbola вресией не ниже 7.17
