\i tables_1.sql;

-- Задание: 1 (Serge I: 2002-09-30)
-- Найдите номер модели, скорость и размер жесткого диска для всех ПК стоимостью
-- менее 500 дол. Вывести: model, speed и hd

select
  model, speed, hd
from pc
where price < 500.0::money
;
-- \q

-- Задание: 2 (Serge I: 2002-09-21)
-- Найдите производителей принтеров. Вывести: maker

select
  maker
from product
where type = 'printer'
group by maker
;
-- \q

-- Задание: 3 (Serge I: 2002-09-30)
-- Найдите номер модели, объем памяти и размеры экранов ПК-блокнотов, цена
-- которых превышает 1000 дол.

select
  model, ram, screen
from laptop
where price > 1000::money
;
-- \q

-- Задание: 4 (Serge I: 2002-09-21)
-- Найдите все записи таблицы Printer для цветных принтеров.

select *
from printer
where color = 'y'
;
-- \q

-- Задание: 5 (Serge I: 2002-09-30)
-- Найдите номер модели, скорость и размер жесткого диска ПК, имеющих 12x или
-- 24x CD и цену менее 600 дол.

select
  model, speed, hd
from pc
where (cd = '12x' or cd = '24x') and price < 600::money
;
-- \q

-- Задание: 6 (Serge I: 2002-10-28)
-- Для каждого производителя, выпускающего ПК-блокноты c объёмом жесткого диска
-- не менее 10 Гбайт, найти скорости таких ПК-блокнотов. Вывод: производитель,
-- скорость.

select
  -- DISTINCT завтавляет вотзвращать только уникальные строки в SELECT, по сути
  -- не производит группировку, а просто игнорирует не уникальные строки.
  DISTINCT p.maker,
  l.speed
from laptop l
left join product p on p.model = l.model
where
  l.hd >= 10
;
-- \q

-- Задание: 7 (Serge I: 2002-11-02)
-- Найдите номера моделей и цены всех имеющихся в продаже продуктов (любого типа) производителя B (латинская буква).

select DISTINCT
  pc.model,
  pc.price
from product p
inner join pc on pc.model = p.model
where p.maker = 'B'
union
select DISTINCT
  laptop.model,
  laptop.price
from product p
inner join laptop on laptop.model = p.model
where p.maker = 'B'
union
select DISTINCT
  printer.model,
  printer.price
from product p
inner join printer on printer.model = p.model
where p.maker = 'B'
;

select
  a.model,
  a.price
from
  (
    select model, price
    from pc
    union
    select model, price
    from laptop
    union
    select model, price
    from printer
  ) as a
left join
  product p on p.model = a.model
where
  p.maker = 'B'
;
-- \q

-- Задание: 8 (Serge I: 2003-02-03)
-- Найдите производителя, выпускающего ПК, но не ПК-блокноты.

select distinct
  p.maker
from product p
where
  p.type = 'pc'
;

select distinct
  p.maker
from product p
where
  p.type = 'laptop'
;

select distinct
  p.maker
from product p
left join (
  select distinct
    p.maker
  from product p
  where
    p.type = 'laptop'
) p2 on p2.maker = p.maker
where
  p.type = 'pc'
  and p2.maker is null
;
-- \q

-- Задание: 9 (Serge I: 2002-11-02)
-- Найдите производителей ПК с процессором не менее 450 Мгц. Вывести: Maker

select distinct p.maker
from pc
left join product p on p.model = pc.model
where speed >= 450
;
-- \q

-- Задание: 10 (Serge I: 2002-09-23)
-- Найдите модели принтеров, имеющих самую высокую цену. Вывести: model, price

-- Постгрес посасывает - отсутствует реализация `SELECT TOP 1 WITH TIES`

-- SELECT top 1 WITH TIES model, price
-- FROM Printer
-- ORDER BY price DESC

select distinct model, price
from printer
where price = (select price from printer order by price desc limit 1)
;
-- select distinct model, price
-- from printer
-- where price = (select top 1 price from printer order by price desc)
-- \q

-- Задание: 11 (Serge I: 2002-11-02)
-- Найдите среднюю скорость ПК.

select avg(speed)
from pc
;
-- \q

-- Задание: 12 (Serge I: 2002-11-02)
-- Найдите среднюю скорость ПК-блокнотов, цена которых превышает 1000 дол.

select avg(speed)
from laptop
where price > 1000::money
;
-- \q

-- Задание: 13 (Serge I: 2002-11-02)
-- Найдите среднюю скорость ПК, выпущенных производителем A.

select avg(speed)
from pc
inner join product p on p.model = pc.model
where p.maker = 'A'
;
-- \q

-- Задание: 15 (Serge I: 2003-02-03)
-- Найдите размеры жестких дисков, совпадающих у двух и более PC. Вывести: HD

select distinct p.hd
from pc p
group by hd
having
  count(*) >= 2
;
-- \q

-- Задание: 16 (Serge I: 2003-02-03)
-- Найдите пары моделей PC, имеющих одинаковые скорость и RAM. В результате
-- каждая пара указывается только один раз, т.е. (i,j), но не (j,i), Порядок
-- вывода: модель с большим номером, модель с меньшим номером, скорость и RAM.

-- select
--  distinct a.model, b.model,
--  a.speed, a.ram
-- from
--  pc a, pc b
-- where
--  a.speed = b.speed
--  and a.ram = b.ram
--  and a.model > b.model
-- ;

select distinct p1.model, p2.model, p1.speed, p1.ram
from pc p1
left join pc p2 on p2.speed = p1.speed and p2.ram = p1.ram
where p1.model > p2.model
;
-- \q

-- Задание: 17 (Serge I: 2003-02-03)
-- Найдите модели ПК-блокнотов, скорость которых меньше скорости каждого из ПК.
-- Вывести: type, model, speed

select distinct p.type, l.model, l.speed
from laptop l
left join product p on p.model = l.model
where speed < (
  select min(speed)
  from pc
)
;
-- \q

-- Задание: 18 (Serge I: 2003-02-03)
-- Найдите производителей самых дешевых цветных принтеров. Вывести: maker, price

-- select
--  distinct product.maker,
--  printer.price
-- from
--  printer, product
-- where
--  printer.model = product.model
--  and printer.color = 'y'
--  and printer.price = (
--   select min(price)
--   from printer
--   where printer.color = 'y'
--  )

select distinct p.maker, pr.price
from printer pr
inner join product p on p.model = pr.model
where
  pr.price = (
    select min(price)
    from printer
    where
      color = 'y'
  )
  and pr.color = 'y'
;
-- \q

-- Задание: 19 (Serge I: 2003-02-13)
-- Для каждого производителя, имеющего модели в таблице Laptop, найдите средний
-- размер экрана выпускаемых им ПК-блокнотов.
-- Вывести: maker, средний размер экрана.

-- select product.maker, avg(laptop.screen)
-- from product
-- right join laptop on laptop.model = product.model
-- group by product.maker
-- ;

select pr.maker, avg(l.screen)
from laptop l
inner join product pr on pr.model = l.model
group by pr.maker
;
-- \q

-- Задание: 20 (Serge I: 2003-02-13)
-- Найдите производителей, выпускающих по меньшей мере три различных модели ПК.
-- Вывести: Maker, число моделей ПК.

select maker, count(model)
from product
where
  type = 'pc'
group by maker
having
  count(model) >= 3
;
-- \q

-- Задание: 21 (Serge I: 2003-02-13)
-- Найдите максимальную цену ПК, выпускаемых каждым производителем, у которого
-- есть модели в таблице PC.
-- Вывести: maker, максимальная цена.

select product.maker, max(pc.price)
from product, pc
where
  product.model = pc.model
group by product.maker
;

select pr.maker, max(p.price)
from pc p
inner join product pr on pr.model = p.model
group by pr.maker
;
-- \q


-- Задание: 22 (Serge I: 2003-02-13)
-- Для каждого значения скорости ПК, превышающего 600 МГц, определите среднюю
-- цену ПК с такой же скоростью. Вывести: speed, средняя цена.

select speed, avg(price::numeric)
from pc
where
  speed > 600
group by speed
;
-- \q

-- Задание: 23 (Serge I: 2003-02-14)
-- Найдите производителей, которые производили бы как ПК
-- со скоростью не менее 750 МГц, так и ПК-блокноты со скоростью не менее 750 МГц.
-- Вывести: Maker

-- select distinct p.maker
-- from product p
-- left join pc a on a.model = p.model
-- where
--   a.speed >= 750
--   and p.maker in (
--     select p.maker
--     from product p
--     left join laptop l on l.model = p.model 
--     where l.speed >= 750
--   )
-- ;

select a.maker
from (
  select distinct product.maker
  from pc, product
  where
    pc.model = product.model
    and pc.speed >= 750
) a
inner join (
  select distinct product.maker
  from laptop, product
  where
    laptop.model = product.model
    and laptop.speed >= 750
) b on b.maker = a.maker
;

select distinct product.maker
from pc, product
where
  pc.model = product.model
  and pc.speed >= 750
INTERSECT
select distinct product.maker
from laptop, product
where
  laptop.model = product.model
  and laptop.speed >= 750
;
-- \q

-- Задание: 24 (Serge I: 2003-02-03)
-- Перечислите номера моделей любых типов, имеющих самую высокую цену по всей имеющейся в базе данных продукции.

select model
from (
  select model, price from pc
  union
  select model, price from laptop
  union
  select model, price from printer
) a
where
  a.price = (
    select max(price)
    from (
      select max(price) as price from pc
      union
      select max(price) as price from laptop
      union
      select max(price) as price from printer
    ) a
  )
;
-- \q

-- Задание: 25 (Serge I: 2003-02-14)
-- Найдите производителей принтеров, которые производят ПК с наименьшим объемом
-- RAM и с самым быстрым процессором среди всех ПК, имеющих наименьший объем
-- RAM. Вывести: Maker

-- В самоучителе направляют на запрос с использованием IN конструкции:
select distinct maker
from product
where
  model IN (
    select model
    from pc 
    where
      ram = (
        select min(ram) from pc
      )
      and speed = (
        select max(speed) from pc
        where
          ram = (
            select min(ram) from pc
          )
      )
  )
  and maker IN (
    select maker
    from product
    where type = 'printer'
  )
;

-- Мне по душе пересечение, которое напросилось из фразы "Найдите производителей
-- принтеров, которые производят ПК":
select product.maker
from pc
inner join product on product.model = pc.model
where
  ram = (
    select min(ram)
    from pc
  )
  and speed = (
    select max(speed)
    from pc
    where ram = (
      select min(ram)
      from pc
    )
  )
intersect
select maker
from product
where
  type = 'printer'
;
-- \q

-- Задание: 26 (Serge I: 2003-02-14)
-- Найдите среднюю цену ПК и ПК-блокнотов, выпущенных производителем A
-- (латинская буква). Вывести: одна общая средняя цена.

select avg(price::numeric)
from (
  select price from pc, product where product.model = pc.model and product.maker = 'A'
  union all
  select price from laptop, product where product.model = laptop.model and product.maker = 'A'
) a
;
-- \q

-- Задание: 27 (Serge I: 2003-02-03)
-- Найдите средний размер диска ПК каждого из тех производителей, которые
-- выпускают и принтеры. Вывести: maker, средний размер HD.

-- select m.maker, g.avg
-- from (
--   select distinct maker
--   from product
--   where type = 'printer'
-- ) as m
-- inner join
-- (
--   select a.maker, avg(b.hd) as avg
--   from product a
--   inner join pc b on b.model = a.model
--   group by a.maker
-- ) as g on g.maker = m.maker
-- ;

select product.maker, avg(pc.hd)
from pc, product
where
  product.model = pc.model
  and product.maker IN (
    select maker
    from product
    where type = 'printer'
  )
group by product.maker
;
-- \q

-- Задание: 28 (Serge I: 2012-05-04)
-- Используя таблицу Product, определить количество производителей, выпускающих
-- по одной модели.

select count(a.maker)
from (
  select maker
  from product
  group by maker
  having
    count(model) = 1
) a
;
-- \q




