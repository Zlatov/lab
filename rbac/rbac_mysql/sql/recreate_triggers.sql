DROP TRIGGER IF EXISTS `tbi_user`;
DROP TRIGGER IF EXISTS `tbi_rbacrole`;

CREATE TRIGGER `tbi_user` BEFORE INSERT ON `user` FOR EACH ROW
trigger_label:BEGIN
	IF @disable_triggers IS NOT NULL AND @disable_triggers = 1 THEN
		LEAVE trigger_label;
	END IF;
	IF NEW.`name` = '' THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Попытка создать пользователя с пустым именем.';
		LEAVE trigger_label;
	END IF;
END;

CREATE TRIGGER `tbi_rbacrole` BEFORE INSERT ON `rbac_role` FOR EACH ROW
trigger_label:BEGIN
	IF @disable_triggers IS NOT NULL AND @disable_triggers = 1 THEN
		LEAVE trigger_label;
	END IF;
	IF NEW.`name` = '' THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Попытка создать роль с пустым именем.';
		LEAVE trigger_label;
	END IF;
END;
