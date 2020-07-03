# Создаст дамп нескольких БД с инструкциями их создания
mysqldump --user=lab --routines --triggers --password=lab --databases lab lab2 > ./temp_labs.sql
exit 0

# Создать дамп одной БД (без инструкции создания БД)
mysqldump --routines --triggers lab > ./temp_lab.sql
