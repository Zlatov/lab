\i tables_3.sql;

-- Задание: 14 (Serge I: 2002-11-05)
-- Найдите класс, имя и страну для кораблей из таблицы Ships, имеющих не менее
-- 10 орудий.

select distinct s.class, s.name, c.country
from classes c
INNER JOIN ships s on s.class = c.class
where c.numGuns >= 10
;
-- \q


-- Задание: 31 (Serge I: 2002-10-22)
-- Для классов кораблей, калибр орудий которых не менее 16 дюймов, укажите класс
-- и страну.

-- 1. Classes (class, type, country, numGuns, bore, displacement)
-- 2. Ships (name, class, launched)

select distinct class, country
from classes
where
  bore >= 16
;

-- Задание: 32 (Serge I: 2003-02-17)
-- Одной из характеристик корабля является половина куба калибра его главных
-- орудий (mw). С точностью до 2 десятичных знаков определите среднее значение
-- mw для кораблей каждой страны, у которой есть корабли в базе данных.

-- 1. Classes (class, type, country, numGuns, bore, displacement)
-- 2. Ships (name, class, launched)
-- 4. Outcomes (ship, battle, result)

select a.country, cast(avg(bore*bore*bore/2) as decimal(9,2)) as weight
from (
  select c.country, c.bore
  from ships s
  inner join classes c on s.class = c.class
  union all
  select c.country, c.bore
  from (
    select distinct ship
    from outcomes
  ) o
  inner join classes c on c.class = o.ship
  where
    o.ship not in (
      select distinct name from ships
    )
) a
group by a.country
;
-- \q

-- Задание: 33 (Serge I: 2002-11-02)
-- Укажите корабли, потопленные в сражениях в Северной Атлантике (North
-- Atlantic). Вывод: ship.


