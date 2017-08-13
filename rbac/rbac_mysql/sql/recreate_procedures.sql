DROP PROCEDURE IF EXISTS `add_user`;
DROP PROCEDURE IF EXISTS `add_role`;
DROP PROCEDURE IF EXISTS `add_perm`;
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
