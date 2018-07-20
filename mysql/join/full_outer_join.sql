SOURCE ab.sql

INSERT INTO `a` VALUES (1,'1'), (2,'2');
INSERT INTO `b` VALUES (1,'1'), (3,'3');

select * from a a
left join b b on b.b_id = a.a_id;

select 
	ifnull(full_outer_join_ab.a_id, full_outer_join_ab.b_id) as id,
	full_outer_join_ab.a_name,
	full_outer_join_ab.b_name
from (
	select * from a a
	left outer join b b on b.b_id = a.a_id
	union
	select * from a a
	right outer join b b on b.b_id = a.a_id
) full_outer_join_ab;
