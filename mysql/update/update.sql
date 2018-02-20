drop table if exists test1;

create table if not exists test1 (
	id int,
	value int
);

drop table if exists test2;

create table if not exists test2 (
	id int,
	value int
);

insert into test1 values (1,1), (2,2);
insert into test2 values (1,null), (2,null);

select * from test2;

update test2
inner join test1 on test1.id = test2.id
set test2.value = test1.value
-- set test2.value = if(tablea.value > 0, tablea.value, tableb.value)
where test2.id = 1;

select * from test2;

update test2
inner join (
	select *
	from test1
) as t1 on t1.id = test2.id
set test2.value = t1.value;

select * from test2;
