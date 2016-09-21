SELECT
	t.id as id
	,t.pid as pid
	,t.header as header
	,r.aid as aid
	,r.did as did
FROM
	ct_tree t
JOIN
	ct_tree_rel r
	ON r.aid = t.id