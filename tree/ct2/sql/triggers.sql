DROP TRIGGER IF EXISTS `tai_tree`;
DROP TRIGGER IF EXISTS `tbd_tree`;
DROP TRIGGER IF EXISTS `tbu_tree`;

CREATE TRIGGER `tai_tree` AFTER INSERT ON `tree` FOR EACH ROW
trigger_label:BEGIN
	IF @disable_triggers IS NULL THEN
		-- Если вставляем элемент в корень, то связи не добавляем
		IF NEW.`pid` IS NULL THEN
			LEAVE trigger_label;
		END IF;
		-- Вставляем связи
		INSERT INTO `treerel` (`aid`, `did`)
			-- Выбираем предков указанного родителя (did = idРодителя)
			-- и вставляем записи типа: idПредка, нашId
			SELECT `aid`, NEW.`id`
			FROM `treerel`
		    WHERE `did` = NEW.`pid`
			-- Родитель тоже предок
		    UNION ALL
		    SELECT NEW.`pid`, NEW.`id`;
	END IF;
END;

CREATE TRIGGER `tbd_tree` BEFORE DElETE ON `tree` FOR EACH ROW
BEGIN
	DECLARE count_childrens INT DEFAULT 0;

	-- Проверить существование наследников.
	SELECT count(`id`)
	INTO count_childrens
	FROM `tree`
	WHERE `pid` = OLD.`id`;

	IF count_childrens > 0 THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Нельзя удалять вместе с детьми.';
	END IF;

	DElETE FROM `treerel`
	WHERE `aid` = OLD.`id` OR `did` = OLD.`id`;
END;

CREATE TRIGGER `tbu_tree` BEFORE UPDATE ON `tree` FOR EACH ROW
trigger_label:BEGIN
	DECLARE count_descendant INT DEFAULT 0;

	-- Если родитель изменился.
	IF OLD.`pid` <> NEW.`pid` THEN

		-- Нельзя перемещать в себя
		IF OLD.`id` = NEW.`pid` THEN
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Нельзя перемещать в себя.';
		END IF;

		-- Нельзя перемещать в своих потомков
		SELECT count(*)
		INTO count_descendant
		FROM `treerel` r
		WHERE
			r.`aid` = OLD.`id`
			AND r.`did` = NEW.`pid`;

		IF count_descendant > 0
		THEN
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Нельзя перемещать в своих потомков.';
		END IF;

		-- Удалить связи потомков перемещаемого элемента с предками перемещаемого элемента
		DElETE r2 FROM `treerel` r1
		-- Присоединим всех предков найденных потомков (r2.aid)
		LEFT JOIN `treerel` r2 ON r2.`did` = r1.`did`
		-- Присоединим только тех предков, которые являются предком для узла
		INNER JOIN `treerel` r3 ON r3.`aid` = r2.`aid` and r3.`did` = OLD.`id`
		-- Условие нахождения потомков элемента (r1.did)
		WHERE r1.`aid` = OLD.`id`;

		-- Удаляем связи с перемещаемого элемента с предками.
		DElETE FROM `treerel`
		WHERE `did` = OLD.`id`;

		-- Вставляем связи между перемещаемым элементом с новыми предками
		INSERT INTO `treerel` (`aid`, `did`)
			SELECT `aid`, OLD.`id`
			FROM `treerel`
			WHERE `did` = NEW.`pid`
			UNION ALL
			SELECT NEW.`pid`, OLD.`id`;

		-- Вставляем связи между предками нового родителя и потомками перемещаемго элемента
		INSERT INTO `treerel` (`aid`, `did`)
			SELECT r1.`aid`, r2.`did`
			FROM `treerel` r1
			CROSS JOIN `treerel` r2
			WHERE r1.`did` = NEW.`pid` AND r2.`aid` = OLD.`id`
			-- А так же связи между новым родителем перемещаемого элемента и его потомками
			UNION ALL
			SELECT NEW.`pid`, r1.`did`
			FROM `treerel` r1
			WHERE r1.`aid` = OLD.`id`;
	END IF;
END;
