DROP TRIGGER IF EXISTS `tai_rbac_rolerel`; -- После вставки связи ролей добавляем связи

DELIMITER ;;

CREATE TRIGGER `tai_rbac_rolerel` AFTER INSERT ON `rbac_rolerel` FOR EACH ROW
trigger_label:BEGIN
	IF @disable_triggers IS NOT NULL AND @disable_triggers = 1 THEN
		LEAVE trigger_label;
	END IF;
	-- SET @disable_triggers = 1;
	-- -- Вставляем связи
	-- INSERT INTO `rbac_rolerel` (`aid`, `did`, `dif`)
	-- 	-- Выбираем предков указанного родителя (did = idРодителя)
	-- 	-- и вставляем записи типа: idПредка, нашId
	-- 	SELECT `aid`, NEW.`did`, 2
	-- 	FROM `rbac_rolerel`
	-- 	WHERE `did` = NEW.`aid`;
	-- SET @disable_triggers = 1;
END;;

DELIMITER ;
