	SELECT *
	FROM rbac_rolerel
	WHERE dif = 1


-- SELECT * FROM `user` ORDER BY id ASC;
-- SELECT * FROM `rbac_obj` ORDER BY `level` ASC;
-- SELECT * FROM `rbac_role` ORDER BY `id` ASC;
-- SELECT * FROM `rbac_perm` ORDER BY `id` ASC;
-- SELECT * FROM `rbac_role_perm_obj`;
-- SELECT * FROM `rbac_user_role`;

-- SET @user_id = 1;
-- SET @role_id = 10;

-- CALL get_role_rights(@role_id);
-- CALL get_rights(@user_id);
