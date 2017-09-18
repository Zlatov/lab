SELECT * FROM USER ORDER BY id ASC;

-- CALL get_role_immediate_perm_on_object(1,1);
-- CALL get_roles();
-- CALL get_roles_rel();
-- CALL get_role_perm(1);

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

