-- Выбрать всех потомков
select t.*
from ct_tree_rel r
left join ct_tree t on t.id = r.did
where r.aid = :id

