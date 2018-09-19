DROP TRIGGER IF EXISTS `tbi_tree`;
DROP TRIGGER IF EXISTS `tai_tree`;
DROP TRIGGER IF EXISTS `tbu_tree`;

DELIMITER ;;

-- Перед вставкой в структуру устанавливаем уровень.
CREATE TRIGGER `tbi_tree` BEFORE INSERT ON `tree` FOR EACH ROW
trigger_label:BEGIN
  DECLARE level_of_parent INT DEFAULT 1;
  IF @disable_triggers IS NULL THEN
    -- Если родитель указан - выбираем его уровень и плюс 1.
    IF NEW.`pid` IS NOT NULL THEN
      SELECT `level` + 1 INTO level_of_parent
      FROM `tree`
      WHERE `id` = NEW.`pid`;
    END IF;
    -- Устанавливаем уровень в любом случае (1 если нет родителя).
    SET NEW.`level` = level_of_parent;
  END IF;
END;;

-- После вставки в структуру добавляем связи.
CREATE TRIGGER `tai_tree` AFTER INSERT ON `tree` FOR EACH ROW
trigger_label:BEGIN
  IF @disable_triggers IS NULL THEN
    -- Если вставляем элемент в корень, то связи не добавляем.
    IF NEW.`pid` IS NULL THEN
      LEAVE trigger_label;
    END IF;
    -- Вставляем связи.
    INSERT INTO `tree_rel` (`aid`, `did`)
    -- Выбираем предков указанного родителя (did = idРодителя)
    -- и вставляем записи типа: idПредка, нашId.
    SELECT `aid`, NEW.`id`
    FROM `tree_rel`
    WHERE `did` = NEW.`pid`
    -- Родитель тоже предок
    UNION ALL
    SELECT NEW.`pid`, NEW.`id`;
  END IF;
END;;

-- Перед обновлением структуры обновляем связи
CREATE TRIGGER `tbu_tree` BEFORE UPDATE ON `tree` FOR EACH ROW
trigger_label:BEGIN
  DECLARE count_descendant INT DEFAULT 0;
  DECLARE delta_level INT DEFAULT 0;

  -- Если родитель изменился.
  IF NOT OLD.`pid` <=> NEW.`pid` THEN

    -- Нельзя перемещать в своих потомков
    SELECT count(*)
    INTO count_descendant
    FROM `tree_rel` r
    WHERE
      r.`aid` = OLD.`id`
      AND r.`did` = NEW.`pid`;

    IF count_descendant > 0 THEN
      SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Нельзя перемещать в своих потомков.';
    END IF;

    -- Удалить связи потомков перемещаемого элемента с предками перемещаемого элемента
    DElETE r2 FROM `tree_rel` r1
    -- Присоединим всех предков найденных потомков (r2.aid)
    LEFT JOIN `tree_rel` r2 ON r2.`did` = r1.`did`
    -- Присоединим только тех предков, которые являются предком для узла
    INNER JOIN `tree_rel` r3 ON r3.`aid` = r2.`aid` and r3.`did` = OLD.`id`
    -- Условие нахождения потомков элемента (r1.did)
    WHERE r1.`aid` = OLD.`id`;

    -- Удаляем связи с перемещаемого элемента с предками.
    DElETE FROM `tree_rel`
    WHERE `did` = OLD.`id`;

    IF NEW.`pid` IS NOT NULL THEN

      -- Вставляем связи между перемещаемым элементом с новыми предками
      INSERT INTO `tree_rel` (`aid`, `did`)
        SELECT `aid`, OLD.`id`
        FROM `tree_rel`
        WHERE `did` = NEW.`pid`
        UNION ALL
        SELECT NEW.`pid`, OLD.`id`;

      -- Вставляем связи между предками нового родителя и потомками перемещаемго элемента
      INSERT INTO `tree_rel` (`aid`, `did`)
        SELECT r1.`aid`, r2.`did`
        FROM `tree_rel` r1
        CROSS JOIN `tree_rel` r2
        WHERE r1.`did` = NEW.`pid` AND r2.`aid` = OLD.`id`
        -- А так же связи между новым родителем перемещаемого элемента и его потомками
        UNION ALL
        SELECT NEW.`pid`, r1.`did`
        FROM `tree_rel` r1
        WHERE r1.`aid` = OLD.`id`;

      -- Обновляем уровень перемещаемого элемента
      -- Определяем смещение по уровню
      SELECT CAST(`newparent`.`level` + 1 AS SIGNED) - CAST(`moveditem`.`level` AS SIGNED) INTO delta_level
      FROM `tree` `newparent`
      LEFT JOIN `tree` `moveditem` ON `moveditem`.`id` = OLD.`id`
      WHERE `newparent`.`id` = NEW.`pid`;

      IF delta_level <> 0 THEN
        SET NEW.`level` = OLD.`level` + delta_level;
      END IF;
    ELSE
      SET NEW.`level` = 1;
    END IF;

  END IF;
END;;

DELIMITER ;
