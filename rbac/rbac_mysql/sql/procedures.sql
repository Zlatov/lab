DROP PROCEDURE IF EXISTS `add_user`;
-- DELIMITER ;;

CREATE PROCEDURE `add_user`(IN param_name VARCHAR(255))
procedure_label:BEGIN
	INSERT INTO `user` (`name`)
	VALUES (param_name)
END;
