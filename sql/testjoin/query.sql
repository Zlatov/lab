-- Даны две SQL-таблицы:
-- 
-- employee - сотрудник
-- - id
-- - first_name - имя
-- - last_name - фамилия
-- - salary - размер зарплаты
-- - department_id - отдел
-- 
-- department - отдел
-- - id
-- - name - название отдела
-- 
-- Список имён и фамилий всех сотрудников с названиями отделов, к которым каждый из них привязан
-- Список отделов с количеством сотрудников в каждом из них
-- Список отделов, в которых нет сотрудников
-- Список отделов, к которым привязано более двух сотрудников
-- Список отделов с указанием средней и максимальной зарплаты в каждом из них, отсортированный по убыванию средней зарплаты
-- 





-- Список имён и фамилий всех сотрудников с названиями отделов, к которым каждый из них привязан

select
	`e`.`first_name`,
	`e`.`last_name`,
	`d`.`name`
from
	`employee` `e`
left join
	`department` `d` on `d`.`id` = `e`.`department_id`;

-- Список отделов с количеством сотрудников в каждом из них

select
	`d`.`name`,
	count(`e`.`id`) as `count`
from
	`department` `d`
left join
	`employee` `e` on `e`.`department_id` = `d`.`id`
group by
	`d`.`id`;

-- Список отделов, в которых нет сотрудников

select
	`d`.`name`
from
	`department` `d`
left join
	`employee` `e` on `e`.`department_id` = `d`.`id`
where
	`e`.`department_id` is null;

-- Список отделов, к которым привязано более двух сотрудников

select
	`d`.`name`,
    count(`e`.`id`) as `count`
from
	`department` `d`
left join
	`employee` `e` on `e`.`department_id` = `d`.`id`
group by
	`d`.`id`
having
	`count` > 2;
--     `name` = 'dep4'


-- Список отделов с указанием средней и максимальной зарплаты в каждом из них, отсортированный по убыванию средней зарплаты

select
	`d`.`name`,
    max(`e`.`salary`) as `max`,
    avg(`e`.`salary`) as `avg`
from
	`department` `d`
left join
	`employee` `e` on `e`.`department_id` = `d`.`id`
group by
	`d`.`id`
order by
	`avg` desc
	
