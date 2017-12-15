DROP PROCEDURE IF EXISTS `get_seo`;
DROP PROCEDURE IF EXISTS `set_seo`;

DELIMITER ;;

CREATE PROCEDURE `get_seo`(IN p_id varchar(12))
procedure_label:BEGIN
	SELECT *
	FROM seo
	WHERE id = p_id;
END;;

CREATE PROCEDURE `set_seo`(
	IN p_id varchar(13),
	IN p_title varchar(256),
	IN p_description varchar(512),
	IN p_keywords varchar(256),
	IN p_h1 varchar(256)
)
procedure_label:BEGIN
	DECLARE idCharLength INT;
	DECLARE descriptionCharLength INT;
	SELECT CHAR_LENGTH( p_id ) INTO idCharLength;
	IF (idCharLength > 12) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Длинна идентификатора превышает допустимое значение.';
		LEAVE procedure_label;
	END IF;
	SELECT CHAR_LENGTH( p_description ) INTO descriptionCharLength;
	IF (descriptionCharLength > 511) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Длинна description превышает допустимое значение.';
		LEAVE procedure_label;
	END IF;
	INSERT INTO seo VALUES (p_id, p_title, p_description, p_keywords, p_h1)
	ON duplicate KEY UPDATE
		title=IF(p_title<=>NULL, title, p_title),
		description=IF(p_description<=>NULL, description, p_description),
		keywords=IF(p_keywords<=>NULL, keywords, p_keywords),
		h1=IF(p_h1<=>NULL, h1, p_h1);
END;;

-- CREATE PROCEDURE `set_seo_loop`(
-- 	IN p_id varchar(13),
-- 	IN p_title varchar(256),
-- 	IN p_description varchar(512),
-- 	IN p_keywords varchar(256),
-- 	IN p_h1 varchar(256)
-- )
-- procedure_label:BEGIN
--     DECLARE EXIT HANDLER FOR SQLEXCEPTION
--     BEGIN
--       ROLLBACK;
--     END;
--     START TRANSACTION;
--     COMMIT;
-- END;;

DELIMITER ;
