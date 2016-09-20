-- Выбрать всех потомков
SELECT * FROM tree.ct_tree t
JOIN tree.ct_tree_rel r ON (r.cid = t.id)
WHERE r.pid = :parent