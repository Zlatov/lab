USE `tree`;

DROP PROCEDURE if exists `tree_ct_add`;
DROP PROCEDURE if exists `tree_ct_del`;
DROP PROCEDURE if exists `tree_ct_move`;

CREATE PROCEDURE `tree_ct_add`(
	in param_parent_id int(11),
	in param_header varchar(255)
)
BEGIN
	DECLARE last_id INT(11);

	START TRANSACTION;

	-- Вставляем данные
	INSERT INTO `ct_tree` (`pid`, `header`)
	VALUES (param_parent_id, param_header);

	-- Определяем id нового элемента
	SET last_id = LAST_INSERT_ID();

	-- Вставляем связи
	INSERT INTO `ct_tree_rel` (`aid`, `did`)
		-- Выбираем связи предков с родителем (did = idРодителя)
		-- и вставляем записи типа: idПредка, нашId
		SELECT `aid`, last_id
		FROM `ct_tree_rel`
	    WHERE `did` = param_parent_id
		-- Родитель тоже предок
	    UNION ALL
	    SELECT param_parent_id, last_id;

	COMMIT;
END;

CREATE PROCEDURE `tree_ct_del`(
	in param_id int(11),
	in param_r tinyint(1)
)
procedure_label:BEGIN
	DECLARE count_descendant INT DEFAULT 0;

	START TRANSACTION;

	SELECT count(`did`)
	INTO count_descendant
	FROM `ct_tree_rel`
	WHERE `aid` = param_id;

	IF count_descendant > 0 AND param_r = 0 THEN
		SELECT count_descendant;
		LEAVE procedure_label;
	END IF;

	DElETE FROM `ct_tree_rel`
	WHERE `aid` = param_id OR `did` = param_id;

	DElETE FROM `ct_tree`
	WHERE `id` = param_id;

	COMMIT;
END;

CREATE PROCEDURE `tree_ct_move`(
	in param_eid int(11),
	in param_tid int(11)
)
procedure_label:BEGIN
	DECLARE count_descendant INT DEFAULT 0;

	START TRANSACTION;

	-- tid <> eid
	IF param_eid = param_tid THEN
		SELECT 'into itself';
		LEAVE procedure_label;
	END IF;

	-- tid нет среди потомков eid
	SELECT
		count(*)
	INTO
		count_descendant
	FROM
		`ct_tree_rel` r
	WHERE
		r.`aid` = param_eid
		AND r.`did` = param_tid;

	IF count_descendant > 0
	THEN
		SELECT 'into descendant';
		LEAVE procedure_label;
	END IF;

	UPDATE `ct_tree`
	SET `pid` = param_tid
	WHERE `id` = param_eid;

	DElETE FROM `ct_tree_rel`
	WHERE `did` = param_eid;

	INSERT INTO `ct_tree_rel` (`aid`, `did`)
		SELECT `aid`, param_eid
		FROM `ct_tree_rel`
		WHERE `did` = param_tid
		UNION ALL
		SELECT param_tid, param_eid;

	COMMIT;
END;
