что такое nat
как работает proxy
как преобразуется домен в ip
как работает http протокол

## Режим восстановления

Как переключить файловую систему в режим чтения записи (file system in recovery
mode to read-write mode)

```sh
mount -o rw,remount /
```


## Определить на какой диск установлена Ubuntu

```sh
sudo fdisk -l # Подробно о дисках
lsblk # Покажет колонку MOUNTPOINT в которой можно найти корень нашей системы: /
```


## synaptic - менеджер пакетов

## Форматирование флешки

```sh
# Проверим наличие Flash-накопителя:

fdisk -l

# Выведет информацию о всех подключённых накопителях и их разделах.

Disk /dev/sdb: 3,8 GiB, 4055885824 bytes, 1980413 sectors
Units: sectors of 1 * 2048 = 2048 bytes
Sector size (logical/physical): 2048 bytes / 2048 bytes
I/O size (minimum/optimal): 2048 bytes / 2048 bytes
Disklabel type: dos
Disk identifier: 0x6f20736b
Устр-во    Загрузочный Start Конец    Blocks   Id  System
/dev/sdb1  *           512   1980412  3959802  7   HPFS/NTFS/exFAT

# /dev/sdb1 - флешка с которой будем работать.

# Нужно проверить примонтирована ли флэшка.
# Выводит список примонтированных устройств.
df -h /dev/sdb1

# Если примонтирована, отмонтировать:
umount /dev/sdb1

# Теперь можно форматировать, форматировать будем в ntfs командой mkfs:
mkfs.ntfs -L name /dev/sdb1
# mkfs — комада для форматирования.
# ntfs — файловая система.
# -L — аргумент, позволяющий присвоить имя нашей флешки (недоступен для fat32).
# name — имя (метка) нашей флешки.
# /dev/sdb1 — путь к флешке.
```

Команды для форматирования в другие файловые системы предназначенные для
Flash-накопителей:

```sh
mkfs.ntfs # NTFS
mkfs.msdos # MSDOS
mkfs.vfat # VFAT (расширенная FAT32)
```


## Чувствительность мыши

```sh
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

__Inkscape__

Неплохой редактор векторных изображений.

__Krita__

Неплохой редактор растровой графики.

__OBS Studio__

Запись, стриминг видео.

__Shotcut__

Редактор видео.

__Shutter__ (PrintScreen as PicPick)

Принтскрины, почти как PicPick в винде.

__VirtualBox__

Отключить захват клавиатуры чтобы быстро переключаться с поммощью Alt + Tab из
винды в линукс, а не по окнам винды:

Файл → Настройки → Ввод → Автозахват клавиатуры (убрать галку)


## FreeRdp

```sh
xfreerdp /cert-ignore –no-nego /u:administrator /p:123 /v:192.168.172.129 /port:2179 /vmconnect:8021D293-FA6F-4CB5-AFD2-2499936D0949
xfreerdp --version

# case of 1.0.2 the "old" command line needs to be used. That would be something
# like xfreerdp -u username servername:port - server name and port must be the
# last argument.

xfreerdp -u username servername:port
```


## pv (Pipe Viewer)

If you're just importing from a dump file from the CLI on \*nix, e.g.

```
mysql -uxxx -pxxx dbname < /sqlfile.sql
```

then first install pipe viewer on your OS then try something like this:

```
pv sqlfile.sql | mysql -uxxx -pxxxx dbname
```

which will show a progress bar as the program runs.

## Изменить скорость сетевой карты

```sh
# Посмотреть интерфейсы
ifconfig
# Просмотреть вывода буфера сообщений ядра в стандартный поток, может там какие неполадки с сетевухой...
dmesg | grep -i 0Mbps
# включает функцию автосогласования
sudo ethtool -s eth0 autoneg on
# отключает автосогласование, включает полудуплекс и устанавливает скорость до 10 Мбит/с
sudo ethtool -s eth0 speed 10 duplex half autoneg off
# ...
sudo ethtool -s eth0 speed 100 duplex full autoneg off
# ...
sudo ethtool -s eth0 speed 1000 duplex full autoneg off
```

## Принтскрин скриншот printScreen screenshot

```sh
# Если не получается создать скриншот с указателем мыши - успейте навести
# указатель на нужное место за 5 секунд!:
sleep 5 && gnome-screenshot -p
```
