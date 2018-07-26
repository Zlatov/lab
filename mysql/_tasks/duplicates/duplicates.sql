drop table if exists table_a;

create table table_a (
  id int unsigned not null auto_increment,
  name varchar(255),
  primary key (id)
);

insert into table_a (name) values ('1'), ('1'), ('1'), ('2'), ('2'), ('3'), ('4');

-- Посчитать количество повторений каждого имени
select
  a.name,
  count(a.id) as count_of_this
from table_a a
group by a.name;

-- Выбрать только дублирующиеся имена
select
  a.name,
  count(a.id) as count_of_this
from table_a a
group by a.name
having count_of_this > 1;

-- Количество дублирующихся имён
select
  count(*) as count_duplicates
from (
  select
    a.name,
    count(a.id) as count_of_this
  from table_a a
  group by a.name
  having count_of_this > 1
) select_count_each_name;
