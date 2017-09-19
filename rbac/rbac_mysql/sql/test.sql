-- SELECT * FROM `user` ORDER BY id ASC;
-- SELECT * FROM `rbac_obj` ORDER BY `level` ASC;
-- SELECT * FROM `rbac_role` ORDER BY `id` ASC;
-- SELECT * FROM `rbac_perm` ORDER BY `id` ASC;
-- SELECT * FROM `rbac_role_perm_obj`;
-- SELECT * FROM `rbac_user_role`;


SET @user_id = 1;

-- SELECT * FROM `user` WHERE `id` = @user_id;

-- SELECT
-- 	u.id as u_id,
-- 	u.name as u_name,
-- 	ur.user_id as ur_user_id,
-- 	ur.role_id as ur_role_id,
-- 	r.id as r_id,
-- 	r.name as r_name
-- FROM `user` u
-- left join `rbac_user_role` ur on ur.user_id = u.id
-- left join `rbac_role` r on r.id = ur.role_id
-- WHERE u.id = @user_id;


SET @role_id = 12;

SELECT
	-- rr.*,
	-- rpm.*,
	-- o.*,
	-- p.*
	concat(p.sid, '_', o.sid),
	concat(p.description, ' ', o.name)
FROM rbac_role r
LEFT JOIN rbac_rolerel rr ON rr.did = r.id
INNER JOIN rbac_role_perm_obj rpm ON rpm.role_id = rr.aid OR rpm.role_id = r.id
LEFT JOIN rbac_obj o ON o.id = rpm.obj_id
LEFT JOIN rbac_perm p ON p.id = rpm.perm_id
WHERE r.id = @role_id;


-- SET @role_id = 1;
-- -- SET @role_id = '1,5';
-- -- SELECT * from rbac_role
-- -- where FIND_IN_SET (id, @role_id);

-- SELECT p.*
-- FROM rbac_role r
-- LEFT JOIN rbac_rolerel rr ON rr.did = r.id
-- LEFT JOIN rbac_role rp ON rp.id = rr.aid
-- LEFT JOIN rbac_perm_role pr ON pr.role_id = rp.id OR pr.role_id = r.id
-- LEFT JOIN rbac_perm p ON p.id = pr.perm_id
-- WHERE r.id = @role_id
-- GROUP BY p.id;

-- SET @user_id = 1;

-- SELECT p.*
-- FROM rbac_assignment a
-- LEFT JOIN rbac_role r ON r.id = a.role_id
-- LEFT JOIN rbac_rolerel rr ON rr.did = r.id
-- LEFT JOIN rbac_role rp ON rp.id = rr.aid
-- LEFT JOIN rbac_perm_role pr ON pr.role_id = rp.id OR pr.role_id = r.id
-- LEFT JOIN rbac_perm p ON p.id = pr.perm_id
-- WHERE a.user_id = @user_id
-- GROUP BY p.id

