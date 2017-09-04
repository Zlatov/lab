-- DROP DATABASE IF EXISTS `lab`;
-- CREATE SCHEMA `lab` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
-- USE lab;

DROP TABLE IF EXISTS `test`;

CREATE TABLE `test` (
  `id` INT unsigned NOT NULL auto_increment,
  `name` varchar(128) NOT NULL,
  PRIMARY KEY (`id`)
)
engine=innodb
auto_increment 1
DEFAULT charset=utf8
COLLATE utf8_general_ci;

INSERT INTO test (name) VALUES ('asd'),('bsd'),('bsd'),('asd');

SELECT * FROM test;

PREPARE select_test FROM 'select id from test where name = ?;';
SET @name = 'bsd';
EXECUTE select_test USING @name;
DEALLOCATE PREPARE select_test;

DROP PROCEDURE IF EXISTS `test_procedure`;
DROP PROCEDURE IF EXISTS `test_procedure2`;

DELIMITER ;;

CREATE PROCEDURE lab.test_procedure(IN p_name varchar(255))
procedure_label:BEGIN
	-- SELECT 'as' AS `as`;
	SELECT t.id AS `ident`, t.name FROM test t WHERE name = p_name;
END;;

CREATE PROCEDURE test_procedure2(IN p_name varchar(255))
procedure_label:BEGIN
	PREPARE stmt FROM 'select id from test where name = ?;';
	SET @name = p_name;
	EXECUTE stmt USING @name;
	DEALLOCATE PREPARE stmt;
END;;

DELIMITER ;

CALL lab.test_procedure('bsd');
CALL lab.test_procedure2('asd');
