DROP PROCEDURE IF EXISTS `add_user`; -- Добавить пользователя
DROP PROCEDURE IF EXISTS `add_role`; -- Добавить роль
DROP PROCEDURE IF EXISTS `add_perm`; -- Добавить разрешение на объект
DROP PROCEDURE IF EXISTS `add_object`; -- Добавить объект
DROP PROCEDURE IF EXISTS `assign_role_parent`; -- Назначить роли предка (другую роль)
DROP PROCEDURE IF EXISTS `assign_permission_role`; -- Дать разрешение роли
DROP PROCEDURE IF EXISTS `assign_role_user`; -- Назначить роль пользователя
DROP PROCEDURE IF EXISTS `get_role_immediate_perm_on_object`; -- Получить права назначенные непосредственно роли
DROP PROCEDURE IF EXISTS `get_role_perm`; -- Получить права роли
DROP PROCEDURE IF EXISTS `get_roles`;
DROP PROCEDURE IF EXISTS `get_roles_rel`;
DROP PROCEDURE IF EXISTS `get_users`;
DROP PROCEDURE IF EXISTS `get_perm`;
-- DROP PROCEDURE IF EXISTS `get_user_permissions_object`;
DELIMITER ;;

CREATE PROCEDURE `add_user`(IN param_name VARCHAR(128))
procedure_label:BEGIN
	DECLARE nameCharLength INT;
	-- mysql> SELECT LENGTH('重庆'); -> 6 (bytes)
	-- mysql> SELECT CHAR_LENGTH('重庆'); -> 2 (characters)
	SELECT CHAR_LENGTH( param_name ) INTO nameCharLength;
	IF (nameCharLength > 128) THEN
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Длинна имени пользователя превышает допустимое значение.';
		LEAVE procedure_label;
	END IF;
	INSERT INTO `user` (`name`) VALUES (param_name);
END;;

CREATE PROCEDURE `add_object`(
	IN param_pid INT UNSIGNED,
	IN param_name VARCHAR(128),
	IN param_nick VARCHAR(128)
)
procedure_label:BEGIN
	INSERT INTO `rbac_object` (`pid`, `name`, `nick`) VALUES (param_pid, param_name, param_nick);
END;;

CREATE PROCEDURE `get_users`()
procedure_label:BEGIN
	SELECT `id`, `name` FROM `user`;
END;;

CREATE PROCEDURE `add_role`(IN param_name VARCHAR(128))
procedure_label:BEGIN
	DECLARE nameCharLength INT;
	SELECT CHAR_LENGTH( param_name ) INTO nameCharLength;
	IF (nameCharLength > 128) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Длинна имени роли превышает допустимое значение.';
		LEAVE procedure_label;
	END IF;
	INSERT INTO `rbac_role` (`name`) VALUES (param_name);
END;;

CREATE PROCEDURE `assign_role_parent`(IN param_did INT UNSIGNED, IN param_aid INT UNSIGNED)
procedure_label:BEGIN
	IF param_did <=> param_aid OR param_did <=> NULL OR param_aid <=> NULL THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Не верные входные данные.';
		LEAVE procedure_label;
	END IF;
	INSERT INTO `rbac_rolerel` (`aid`, `did`, `dif`) VALUES (param_aid, param_did, 1);
	-- Вставляем связи между предками нового родителя и новым ребёнком
	INSERT INTO `rbac_rolerel` (`aid`, `did`, `dif`)
		-- Выбираем предков нового родителя (did = param_aid)
		-- и вставляем записи типа: найденныеПредки, новыйРебёнок
		SELECT `aid`, param_did, dif + 1
		FROM `rbac_rolerel`
		WHERE `did` = param_aid;
	-- Вставляем связи между потомками нового ребёнка и новым родителем
	INSERT INTO `rbac_rolerel` (`aid`, `did`, `dif`)
		-- Выбираем потомков нового ребенка (aid = param_did)
		-- и вставляем записи типа: новыйРодитель, найденныеПотомки
		SELECT param_aid, `did`, dif + 1
		FROM `rbac_rolerel`
		WHERE `aid` = param_did;
	-- Вставляем связи между потомками нового ребёнка и предками нового родителя
	INSERT INTO `rbac_rolerel` (`aid`, `did`, `dif`)
		-- Выбираем потомков нового ребенка (rr1.aid = param_did),
		-- выбираем предков нового родителя (rr2.did = param_aid)
		-- из пересечения двух таблиц составляем связи
		SELECT `rr2`.`aid`, `rr1`.`did`, `rr1`.`dif` + `rr2`.`dif` + 1
		FROM `rbac_rolerel` rr1
		JOIN `rbac_rolerel` rr2
		WHERE `rr1`.`aid` = param_did AND `rr2`.`did` = param_aid;
END;;

CREATE PROCEDURE `get_roles`()
procedure_label:BEGIN
	SELECT `id`, `name` FROM `rbac_role`;
END;;

CREATE PROCEDURE `get_roles_rel`()
procedure_label:BEGIN
	SELECT `aid`, `did`, `dif` FROM `rbac_rolerel`;
END;;

CREATE PROCEDURE `add_perm`(
	IN param_name VARCHAR(128),
	IN param_object_id INT UNSIGNED,
	IN param_description TEXT
)
procedure_label:BEGIN
	DECLARE nameCharLength INT;
	SELECT CHAR_LENGTH( param_name ) INTO nameCharLength;
	IF (nameCharLength > 128) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Длинна имени разрешения превышает допустимое значение.';
		LEAVE procedure_label;
	END IF;
	INSERT INTO `rbac_perm` (`name`, `description`, `object_id`) VALUES (param_name, param_description, param_object_id);
END;;

CREATE PROCEDURE `get_perm`()
procedure_label:BEGIN
	SELECT `id`, `name` FROM `rbac_perm`;
END;;

CREATE PROCEDURE `assign_permission_role`(IN param_permid INT UNSIGNED, IN param_roleid INT UNSIGNED)
procedure_label:BEGIN
	INSERT INTO `rbac_perm_role` VALUES (param_permid, param_roleid);
END;;

CREATE PROCEDURE `assign_role_user`(IN param_roleid INT UNSIGNED, IN param_userid INT UNSIGNED)
procedure_label:BEGIN
	INSERT INTO `rbac_assignment` VALUES (param_userid, param_roleid);
END;;

CREATE PROCEDURE `get_role_immediate_perm_on_object`(
	IN param_roleid INT UNSIGNED,
	IN param_objectid INT UNSIGNED
)
procedure_label:BEGIN
	SELECT
		p.id,
		p.name,
		p.description,
		p.object_id
	FROM rbac_perm p
	INNER JOIN rbac_perm_role pr ON pr.perm_id = p.id
	WHERE
		p.object_id = param_objectid
		AND pr.role_id = param_roleid;
END;;

CREATE PROCEDURE `get_role_perm`(
	IN param_roleid INT UNSIGNED
)
procedure_label:BEGIN
	SELECT
		*
	FROM rbac_rolerel rr
	WHERE
		rr.did = param_roleid;
END;;

DELIMITER ;
