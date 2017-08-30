DROP PROCEDURE IF EXISTS `add_user`;
DROP PROCEDURE IF EXISTS `add_role`;
DROP PROCEDURE IF EXISTS `add_perm`;

DROP PROCEDURE IF EXISTS `connect_role`;

DROP PROCEDURE IF EXISTS `get_roles`;
DROP PROCEDURE IF EXISTS `get_users`;
DROP PROCEDURE IF EXISTS `get_edges`;
DROP PROCEDURE IF EXISTS `get_perm`;
-- DELIMITER ;;

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
END;

CREATE PROCEDURE `get_users`()
procedure_label:BEGIN
	SELECT `id`, `name` FROM `user`;
END;

CREATE PROCEDURE `add_role`(IN param_name VARCHAR(128))
procedure_label:BEGIN
	DECLARE nameCharLength INT;
	SELECT CHAR_LENGTH( param_name ) INTO nameCharLength;
	IF (nameCharLength > 128) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Длинна имени роли превышает допустимое значение.';
		LEAVE procedure_label;
	END IF;
	INSERT INTO `rbac_role` (`name`) VALUES (param_name);
END;

CREATE PROCEDURE `connect_role`(IN param_did INT UNSIGNED, IN param_aid INT UNSIGNED)
procedure_label:BEGIN
	INSERT INTO `rbac_rolerel` (`aid`, `did`) VALUES (param_aid, param_did);
END;

CREATE PROCEDURE `get_roles`()
procedure_label:BEGIN
	SELECT `id`, `name` FROM `rbac_role`;
END;

CREATE PROCEDURE `get_edges`()
procedure_label:BEGIN
	SELECT `aid`, `did` FROM `rbac_rolerel`;
END;

CREATE PROCEDURE `add_perm`(IN param_name VARCHAR(128), IN param_description TEXT)
procedure_label:BEGIN
	DECLARE nameCharLength INT;
	SELECT CHAR_LENGTH( param_name ) INTO nameCharLength;
	IF (nameCharLength > 128) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Длинна имени разрешения превышает допустимое значение.';
		LEAVE procedure_label;
	END IF;
	INSERT INTO `rbac_perm` (`name`, `description`) VALUES (param_name, param_description);
END;

CREATE PROCEDURE `get_perm`()
procedure_label:BEGIN
	SELECT `id`, `name` FROM `rbac_perm`;
END;
