drop table if exists table_a;
drop table if exists table_b;

create table table_a (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(255) NOT NULL,
  PRIMARY KEY (id)
);

create table table_b (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(255) NOT NULL,
  PRIMARY KEY (id)
);

insert into table_a values (1, ''), (2, '');
insert into table_b values (1, '1'), (2, '2');

update table_a a
inner join table_b b on b.id = a.id
set a.name = b.name;
-- set test2.value = if(tablea.value > 0, tablea.value, tableb.value)
-- where b.id = 1;

select * from table_a;

-- update test2
-- inner join (
-- 	select *
-- 	from test1
-- ) as t1 on t1.id = test2.id
-- set test2.value = t1.value;

-- select * from test2;
