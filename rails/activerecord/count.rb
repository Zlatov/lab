
# Пдсчёт уникальных значений в столбце
# Нет необходимости использовать GROUP BY, достаточно DISTINCT
<<-SQL
  SELECT COUNT(DISTINCT date) FROM records
SQL
# Аналог в ActiveRecord:
Record.count(:date, :distinct => true)
Record.distinct.count(:code)
