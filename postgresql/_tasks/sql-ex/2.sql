\i tables_2.sql;

-- Задание: 29 (Serge I: 2003-02-14)
-- В предположении, что приход и расход денег на каждом пункте приема
-- фиксируется не чаще одного раза в день [т.е. первичный ключ (пункт, дата)],
-- написать запрос с выходными данными (пункт, дата, приход, расход).
-- Использовать таблицы Income_o и Outcome_o.

-- правильно:
select
  point, date, sum(inc) as inc, sum(out) as out
from (
  select point, date, inc, null as out
  from Income_o
  union all
  select point, date, null as inc, out
  from Outcome_o
) as t
group by point, date
;

-- так тоже можно, однако нужно быть уверенным что нет дуликатов на индекс (point, date):
select COALESCE(income_o.point, outcome_o.point), COALESCE(income_o.date, outcome_o.date), inc, out
from income_o 
FULL OUTER JOIN outcome_o on outcome_o.date = income_o.date and outcome_o.point = income_o.point
;
-- \q

-- Задание: 30 (Serge I: 2003-02-14)
-- В предположении, что приход и расход денег на каждом пункте приема
-- фиксируется произвольное число раз (первичным ключом в таблицах является
-- столбец code), требуется получить таблицу, в которой каждому пункту за каждую
-- дату выполнения операций будет соответствовать одна строка.
-- Вывод: point, date, суммарный расход пункта за день (out), суммарный приход
-- пункта за день (inc). Отсутствующие значения считать неопределенными (NULL).

select a.point, a.date, sum(a.out), sum(a.inc)
from (
  select point, date, out, null as inc
  from outcome
  union all
  select point, date, null, inc
  from income
) a
group by a.point, a.date
;
