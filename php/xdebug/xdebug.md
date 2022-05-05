# Xdebug

## Установка

```sh
# Установка пакета в sublime
Xdebug Client
# Установка расширения.
sudo apt-get install php-xdebug
# Установит для версии php.
sudo apt-get install php5.6-xdebug
# Поиск ini-файла установленного расширения.
php --info | grep ini | grep xdeb
# Открытие ini-файла
sudo subl /etc/php/5.6/cli/conf.d/20-xdebug.ini
# Код настройки вставляемый в ini-файл
;;;;;;;;;;
; Xdebug ;
;;;;;;;;;;
xdebug.remote_enable=1
xdebug.remote_handler=dbgp
xdebug.remote_host=127.0.0.1
xdebug.remote_port=9000
xdebug.remote_log="/var/log/xdebug/xdebug.log"
# А ещё эту строчку, чтоб без ?XDEBUG_SESSION_START=sublime.xdebug работало.
xdebug.remote_autostart=true
# Редактирование sublime-проекта (необязательно) для автоматического открывания
# страницы с параметром разрешающим дебаг ?XDEBUG_SESSION_START=sublime.xdebug
  "settings": {
    "xdebug": {
      "url": "http://lab.local",
    }
  }

sudo systemctl restart php5.6-fpm
# restart apache2 nginx ...
```


## Использование в sublime

*  Ctrl Shift + F9  начать отслеживать текущий файл сервисом;
*  Ctrl Shift + F10 остановить отслеживание;
*  Ctrl Shift + F11 отменить окна Xdebug;
*  Ctrl Shift + F12 установить/снять точку останова;
*  Ctrl Shift + F4  дабавить отслеживаемую переменную.
