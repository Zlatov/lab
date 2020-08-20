\i tables_2.sql;

-- Задание: 14 (Serge I: 2002-11-05)
-- Найдите класс, имя и страну для кораблей из таблицы Ships, имеющих не менее
-- 10 орудий.

select distinct s.class, s.name, c.country
from classes c
INNER JOIN ships s on s.class = c.class
where c.numGuns >= 10
;
-- \q


