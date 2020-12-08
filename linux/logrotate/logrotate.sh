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
  rotate 18            # кол-во хранимых сжатых фрагментов (сохраняется последние n ротированных файла)
  size=16M             # максимальный размер несжатого файла; пока ..., файл не будет "ротирован"
  compress             # сжимать ротируемый файл
  nocopytruncate       # не сбрасывать файл журнала после копирования
  copytruncate         # После создания копии, обрезать исходный файл журнала
                       # взамен перемещения старого файла журнала и создания
                       # нового. Это может найти применение в том случае, когда
                       # некоторой программе нельзя указать закрыть её журнал, и
                       # таким образом можно постоянно продолжать запись
                       # (добавление) в существующий файл журнала. Примите во
                       # внимание, что хотя между копированием файла и его
                       # обрезанием очень маленький промежуток времени,
                       # некоторая часть журналируемых данных может быть
                       # потеряна. При использовании этого параметра, не имеет
                       # силы директива create, так как старый файл журнала
                       # остаётся на своём месте.
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

# Пример раз в неделю
/home/deployer/app/appname/log/email.log {
    su deployer deployer
    weekly
    rotate 3
    nocreate
    copytruncate
    nomail
    noolddir
    missingok
    notifempty
    compress
    dateext
    dateformat .%Y-%m-%d
}

# Пример раз в день
/home/deployer/app/appname/shared/log/*.log {
    su deployer deployer
    daily
    rotate 18
    nocreate
    copytruncate
    nomail
    noolddir
    missingok
    notifempty
    #compress
    delaycompress
    dateext
    dateformat .%Y-%m-%d
}
