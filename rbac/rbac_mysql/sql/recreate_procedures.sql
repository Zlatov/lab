DROP PROCEDURE IF EXISTS `add_user`;                                 -- Добавить пользователя
DROP PROCEDURE IF EXISTS `get_users`;                                -- Получить пользователей (пагинационно)

DROP PROCEDURE IF EXISTS `add_obj`;                                  -- Добавить объект

DROP PROCEDURE IF EXISTS `add_role`;                                 -- Добавить роль
DROP PROCEDURE IF EXISTS `get_roles`;                                -- Получить все роли
DROP PROCEDURE IF EXISTS `get_edges`;                                -- Получить все связи ролей

DROP PROCEDURE IF EXISTS `add_perm`;                                 -- Добавить разрешение на объект

DROP PROCEDURE IF EXISTS `set_role_parent`;                          -- Назначить роли предка (другую роль) от которой будут наследоваться права
DROP PROCEDURE IF EXISTS `set_rpo`;                                  -- Дать разрешение роли
DROP PROCEDURE IF EXISTS `set_user_role`;                            -- Назначить роль пользователя

DROP PROCEDURE IF EXISTS `get_rights`;                               -- Получить права пользователя
DROP PROCEDURE IF EXISTS `get_role_rights`;                          -- Получить права роли

DELIMITER ;;


CREATE PROCEDURE `add_user`(IN param_name VARCHAR(255))
procedure_label:BEGIN
	INSERT INTO `user` (`name`) VALUES (param_name);
END;;

CREATE PROCEDURE `get_users`(IN param_from INT UNSIGNED, IN param_limit INT UNSIGNED)
procedure_label:BEGIN
	SELECT SQL_CALC_FOUND_ROWS
		`user`.`id`,
		`user`.`name`
	FROM `user`
	ORDER BY id ASC
	LIMIT param_from, param_limit;
END;;

CREATE PROCEDURE `add_obj`(IN param_pid INT UNSIGNED, IN param_name VARCHAR(255), IN param_sid VARCHAR(255))
procedure_label:BEGIN
	INSERT INTO `rbac_obj` (`pid`, `name`, `sid`) VALUES (param_pid, param_name, param_sid);
END;;

CREATE PROCEDURE `add_role`(IN param_name VARCHAR(255))
procedure_label:BEGIN
	INSERT INTO `rbac_role` (`name`) VALUES (param_name);
END;;

CREATE PROCEDURE `get_roles`()
procedure_label:BEGIN
	SELECT *
	FROM rbac_role;
END;;

CREATE PROCEDURE `get_edges`()
procedure_label:BEGIN
	SELECT *
	FROM `rbac_rolerel`
	WHERE `dif` = 1;
END;;

CREATE PROCEDURE `add_perm`(IN param_sid VARCHAR(255), IN param_description VARCHAR(255))
procedure_label:BEGIN
	INSERT INTO `rbac_perm` (`sid`, `description`) VALUES (param_sid, param_description);
END;;


CREATE PROCEDURE `set_role_parent`(IN param_did INT UNSIGNED, IN param_aid INT UNSIGNED)
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

CREATE PROCEDURE `set_rpo`(IN param_roleid INT UNSIGNED, IN param_permid SMALLINT UNSIGNED, IN param_objid INT UNSIGNED)
procedure_label:BEGIN
	INSERT INTO `rbac_role_perm_obj` VALUES (param_roleid, param_permid, param_objid);
END;;

CREATE PROCEDURE `set_user_role`(IN param_userid INT UNSIGNED, IN param_roleid INT UNSIGNED)
procedure_label:BEGIN
	INSERT INTO `rbac_user_role` VALUES (param_userid, param_roleid);
END;;

CREATE PROCEDURE `get_rights`(IN param_userid INT UNSIGNED)
procedure_label:BEGIN
	SELECT
		p.id as perm_id, p.sid as perm_sid, p.description as perm_name,
		oi.id as oi_id, oi.sid as oi_sid, oi.name as oi_name,
		concat(p.sid, '_', oi.sid) as right_sid,
		concat(p.description, ' ', oi.name) as right_name
	FROM rbac_user_role ur
	LEFT JOIN rbac_rolerel rrel ON rrel.did = ur.role_id
	INNER JOIN rbac_role_perm_obj rpo ON rpo.role_id = rrel.aid OR rpo.role_id = ur.role_id
	LEFT JOIN rbac_obj o ON o.id = rpo.obj_id
	LEFT JOIN rbac_objrel orel ON orel.aid = o.id
	LEFT JOIN rbac_obj oi ON oi.id = orel.did OR oi.id = o.id
	LEFT JOIN rbac_perm p ON p.id = rpo.perm_id
	WHERE ur.user_id = param_userid
	GROUP BY rpo.perm_id, oi.id;
END;;

CREATE PROCEDURE `get_role_rights`(IN param_roleid INT UNSIGNED)
procedure_label:BEGIN
	SELECT
		p.id as perm_id, p.sid as perm_sid, p.description as perm_name,
		oi.id as oi_id, oi.sid as oi_sid, oi.name as oi_name,
		concat(p.sid, '_', oi.sid) as right_sid,
		concat(p.description, ' ', oi.name) as right_name
	FROM rbac_role r
	LEFT JOIN rbac_rolerel rrel ON rrel.did = r.id
	INNER JOIN rbac_role_perm_obj rpo ON rpo.role_id = rrel.aid OR rpo.role_id = r.id
	LEFT JOIN rbac_obj o ON o.id = rpo.obj_id
	LEFT JOIN rbac_objrel orel ON orel.aid = o.id
	LEFT JOIN rbac_obj oi ON oi.id = orel.did OR oi.id = o.id
	LEFT JOIN rbac_perm p ON p.id = rpo.perm_id
	WHERE r.id = param_roleid
	GROUP BY rpo.perm_id, oi.id;
END;;


DELIMITER ;
