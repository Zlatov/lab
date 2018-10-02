#!/usr/bin/env bash
exit 0

# Установка
sudo aptitude install logrotate

# Использование

# Для логов приложения создать файл настройки
sudo touch /etc/logrotate.d/app
subl /etc/logrotate.d/app

# `/etc/logrotate.d/app`
/home/iadfeshchm/projects/zenon/app/log/*.log {
  daily                # ежедневная ротация
  weekly               # ротация раз в неделю
  missingok            # отсутствие файла не является ошибкой
  rotate 17            # кол-во хранимых сжатых фрагментов (сохраняется последние n ротированных файла)
  size=16M             # максимальный размер несжатого файла; пока ..., файл не будет "ротирован"
  compress             # сжимать ротируемый файл
  nocopytruncate       # не сбрасывать файл журнала после копирования
  nocreate             # не создавать пустой журнал
  nodelaycompress      # не откладывать сжатие файла на следующий цикл
  nomail               # не отправлять содержимое удаляемых (старых) журналов по почте
  noolddir             # держать все файлы в одном и том же каталоге
  delaycompress        # сжимать предыдущий файл при следующей ротации 
  notifempty           # не обрабатывать пустые файлы
  create 640 root root # сразу после ротации создать пустой файл с заданными правами и пользователем

  dateext              # добавить в расширение метку даты
  dateformat .%Y-%m-%d # уточнить метку даты (необязательно)
  extension .log       # уточнить расширений (необязательно)

  sharedscripts        # крипты prerotate/postrotate будут выполнены только один раз
                       # не зависимо от количества журналов, подходящих под заданный шаблон
  postrotate           # Между postrotate и endscript расположены команды интерпретатора sh(1), исполняемые непосредственно после ротации.
    if [ -f "`. /etc/apache2/envvars ; echo ${APACHE_PID_FILE:-/var/run/apache2.pid}`" ]; then
            /etc/init.d/apache2 reload > /dev/null
    fi
  endscript
}

# Протестировать созданный файл
sudo logrotate --force /etc/logrotate.d/app
