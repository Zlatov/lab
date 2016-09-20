-- SELECT * FROM tree.ct_tree
-- Выбрать всех предков
SELECT * FROM tree.ct_tree t
JOIN tree.ct_tree_rel r ON (r.pid = t.id)
WHERE r.cid = 10
