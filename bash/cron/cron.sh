#!/bin/bash
exit 0

# Вывод содержимого текущего файла расписания
crontab -l

# Удаление текущего файла расписания
crontab -r

# Cоздание/редактирование файла crontab текущего пользователя
crontab -e
EDITOR=nano crontab -e
