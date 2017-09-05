DROP TRIGGER IF EXISTS `tbi_seo`;

DELIMITER ;;

CREATE TRIGGER `tbi_seo` BEFORE INSERT ON `seo` FOR EACH ROW
trigger_label:BEGIN
	IF @disable_triggers IS NULL THEN
		IF NEW.`id` <=> '' THEN
			SET NEW.`id` = NULL;
		END IF;
	END IF;
END;;

DELIMITER ;
