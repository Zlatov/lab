-- Напишите запросы (БД - “правильная”, умеющая делать подзапросы, различные соединения и прочее):
-- 1. На выборку всех категорий верхнего уровня, начинающихся на “авто”
-- 2. На выборку всех категорий, имеющих не более трёх подкатегорий следующего уровня (без глубины)
-- 3. На выборку всех категорий нижнего уровня (т.е. не имеющих детей)
-- 
-- Напишите индексы, которые позволят сделать эти запросы быстрее.


-- CREATE TABLE category (
--     id integer not null primary key,
--     parent_category_id integer references category(id),
--     name varchar(100) not null
-- );

-- insert into category (id,parent_category_id,`name`) values
-- (1,null,'авто1'),
-- (2,null,'2'),
-- (3,null,'авто 3'),
-- (4,1,'4'),
-- (5,1,'5'),
-- (6,1,'6'),
-- (7,1,'7'),
-- (8,2,'8'),
-- (9,2,'9'),
-- (10,2,'10'),
-- (11,3,'11'),
-- (12,3,'12');

select
	`c`.*
from
	`category` `c`
where
	`c`.`parent_category_id` is null
    and `c`.`name` like 'авто%';



select
	`c`.`id`,
	`c`.`parent_category_id`,
	`c`.`name`,
    count(`c`.`id`) as 'count_cc'
from
	`category` `c`
inner join
	`category` `cc` on `cc`.`parent_category_id` = `c`.`id`
group by
	`cc`.`parent_category_id`
having
	`count_cc` <= 3;



select
	c.*
from
	category c
left join
	category cc on cc.parent_category_id = c.id
where
	cc.parent_category_id is null;


alter table `category` 
add index `idx_category_pcid` (`parent_category_id` asc);
