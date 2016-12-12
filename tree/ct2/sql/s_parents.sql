-- Выбрать всех предков
SELECT t.*
FROM ct_tree_rel r
JOIN ct_tree t ON t.id = r.aid
WHERE r.did = :did
