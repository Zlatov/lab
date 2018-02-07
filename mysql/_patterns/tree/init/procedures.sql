DROP PROCEDURE IF EXISTS `categories_update_level_moved_descendants`;
DROP PROCEDURE IF EXISTS `categories_order_after`;
DROP PROCEDURE IF EXISTS `categories_order_first`;
DROP PROCEDURE IF EXISTS `categories_reorder_cildrens`;
DROP PROCEDURE IF EXISTS `categories_select_all`;
DROP PROCEDURE IF EXISTS `categories_select_childrens`;
DROP PROCEDURE IF EXISTS `categories_count_childrens`;

DELIMITER ;;

CREATE PROCEDURE `categories_update_level_moved_descendants`(IN param_id INT(11))
procedure_label:BEGIN
	DECLARE count_descendant INT DEFAULT 0;
	DECLARE delta_level INT DEFAULT 0;

	-- Определяем есть ли потомки у перемещвемого элемента
	SELECT COUNT(`id`) INTO count_descendant FROM `categories` WHERE `pid` = param_id;

	-- Если есть потомки
	IF count_descendant > 0
	THEN
		-- Определяем на сколько неверно смещение уровня у потомов относительнопредка
		SELECT CAST(`moved_element`.`level` AS SIGNED) + 1 - CAST(`children`.`level` AS SIGNED) INTO delta_level
		FROM `categories` `moved_element`
		LEFT JOIN `categories` `children` ON `children`.`pid` = `moved_element`.`id`
		WHERE `moved_element`.`id` = param_id
		LIMIT 1;

		-- Если есть неверное смещение
		IF delta_level <> 0
		THEN
			-- Выбираем потомков и добавляем delta_level
			UPDATE `categories` `descendants`
			INNER JOIN `%2$s` `relations` ON `relations`.`did` = `descendants`.`id`
			SET `level` = `level` + delta_level
			WHERE `relations`.`aid` = param_id;
		END IF;
	END IF;

END;;

CREATE PROCEDURE `categories_order_after`(IN param_id INT(11), IN param_after_id INT(11))
procedure_label:BEGIN
	DECLARE param_pid INT unsigned DEFAULT NULL;

	UPDATE `categories` `moved_items`
	LEFT JOIN `categories` `after_item` ON `after_item`.`id` = param_after_id
	SET `moved_items`.`order` = `after_item`.`order` + 1
	WHERE
		`moved_items`.`id` = param_id;

	UPDATE `categories` `next_items`
	RIGHT JOIN `categories` `after_item` ON
		`next_items`.`pid` <=> `after_item`.`pid`
		AND `next_items`.`order` >= `after_item`.`order`
		AND if (`next_items`.`order` = `after_item`.`order`, `next_items`.`id` > param_after_id, 1)
		AND `next_items`.`id` <> param_id
	SET `next_items`.`order` = `next_items`.`order` + 2
	WHERE
		`after_item`.`id` = param_after_id;

	SELECT `categories`.`pid` INTO param_pid FROM `categories` WHERE `categories`.`id` = param_after_id;
	CALL categories_reorder_cildrens(param_pid);

END;;

CREATE PROCEDURE `categories_order_first`(IN param_id INT(11), IN param_pid INT(11))
procedure_label:BEGIN
	UPDATE `categories` `moved_items`
	SET `moved_items`.`order` = 0
	WHERE
		`moved_items`.`id` = param_id;

	UPDATE `categories` `next_items`
	SET `next_items`.`order` = `next_items`.`order` + 1
	WHERE
		`next_items`.`pid` = param_pid
		AND `next_items`.`id` <> param_id;

	CALL categories_reorder_cildrens(param_pid);
END;;

CREATE PROCEDURE `categories_reorder_cildrens`(IN param_pid INT(11))
procedure_label:BEGIN
	UPDATE `categories` `childrens`
	INNER JOIN (
		SELECT
			`ch`.`id` as `chid`,
			@rn := @rn + 1 as `row_number`
		FROM `categories` `ch`
		JOIN (SELECT @rn := 0) r
		WHERE `ch`.`pid` <=> param_pid
		ORDER BY `ch`.`order` ASC, `ch`.`id` ASC
	) `childrens_and_row_number` ON `childrens_and_row_number`.`chid` = `childrens`.`id`
	SET `childrens`.`order` = `childrens_and_row_number`.`row_number`;
END;;

CREATE PROCEDURE `categories_select_all`()
procedure_label:BEGIN
	SELECT
		`id`,
		`pid`,
		`header`,
		`level`,
		`order`
	FROM `categories`
	ORDER BY `order` ASC, `id` ASC;
END;;

CREATE PROCEDURE `categories_select_childrens`(IN param_pid INT(11))
procedure_label:BEGIN
	DECLARE parent_id INT(11) DEFAULT NULL;
	SELECT `id` INTO parent_id
	FROM `categories`
	WHERE `id` = param_pid;
	IF parent_id IS NULL THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Попытка найти детей несуществующего родителя.';
	END IF;
	SELECT
		`id`,
		`pid`,
		`header`,
		`level`,
		`order`
	FROM `categories`
	WHERE `pid` = param_pid
	ORDER BY `order` ASC, `id` ASC;
END;;

CREATE PROCEDURE `categories_count_childrens`(IN param_id INT(11))
procedure_label:BEGIN
	DECLARE an_existing_item_id INT(11) DEFAULT NULL;
	-- Проверяем существует ли сам элемент
	SELECT `id` INTO an_existing_item_id
	FROM `categories`
	WHERE `id` = param_id;
	IF an_existing_item_id IS NULL THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Попытка найти детей несуществующего родителя.';
		LEAVE procedure_label;
	END IF;
	-- Выбираем количество детей
	SELECT
		COUNT(`id`) as `count`
	FROM `categories`
	WHERE `pid` = param_id;
END;;

CREATE PROCEDURE `categories_delete_element`(IN param_id INT(11))
procedure_label:BEGIN
	DECLARE an_existing_item_id INT(11) DEFAULT NULL;
	-- Проверяем существует ли сам элемент
	SELECT `id` INTO an_existing_item_id
	FROM `categories`
	WHERE `id` = param_id;
	IF an_existing_item_id IS NULL THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Попытка удалить несуществующий элемент.';
		LEAVE procedure_label;
	END IF;
	-- Удаляем
	DELETE FROM `categories` WHERE `id` = param_id;
END;;

DELIMITER ;
