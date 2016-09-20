SELECT
	t.id as id
	,t.header as header
	,r.pid as pid
	,r.cid as cid
FROM
	ct_tree t
JOIN
	ct_tree_rel r
	ON r.pid = t.id