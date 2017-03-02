DROP TRIGGER IF EXISTS `tai_tree`;
DROP TRIGGER IF EXISTS `tbi_tree_addlevel`;
DROP TRIGGER IF EXISTS `tbd_tree`;
DROP TRIGGER IF EXISTS `tbu_tree`;

-- Перед вставкой в структуру устанавливаем уровень
CREATE TRIGGER `tbi_tree_addlevel` BEFORE INSERT ON `tree` FOR EACH ROW
trigger_label:BEGIN
	DECLARE level_of_parent INT DEFAULT 1;
	IF @disable_triggers IS NULL THEN
		-- Если родитель указан - выбираем его уровень и плюс 1
		IF NEW.`pid` IS NOT NULL THEN
			SELECT `level` + 1 INTO level_of_parent
			FROM `tree`
			WHERE `id` = NEW.`pid`;
		END IF;
		-- Устанавливаем уровень в любом случае (1 если нет родителя)
		SET NEW.`level` = level_of_parent;
	END IF;
END;

-- После вставки в структуру добавляем связи
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

-- Перед удалением из структуры удаляем связи
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

-- Перед обновлением структуры обновляем связи
CREATE TRIGGER `tbu_tree` BEFORE UPDATE ON `tree` FOR EACH ROW
trigger_label:BEGIN
	DECLARE count_descendant INT DEFAULT 0;
	DECLARE delta_level INT DEFAULT 0;

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

		-- Обновляем уровни перемещенных элементов
		-- Определяем смещение по уровню
		SELECT CAST(t.`level` AS SIGNED) - CAST(tt.`level` AS SIGNED) INTO delta_level
		FROM tree t
		LEFT JOIN tree tt ON tt.`id` = OLD.`id`
		WHERE t.`id` = NEW.`pid`;

		SET NEW.`level` = OLD.`level` + delta_level;

		-- UPDATE tree t
		-- LEFT JOIN treerel tr ON tr.`did` = t.`id`
		-- SET `level` = `level` + delta_level
		-- WHERE
		-- 	tr.`aid` = element_id
		-- 	OR t.`id` = element_id;

	END IF;
END;
