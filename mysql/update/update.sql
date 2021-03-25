SELECT '> Из test1 в test2' AS " ";

DROP TABLE IF EXISTS `test1`;
CREATE TABLE IF NOT EXISTS `test1` (
	`id` INT,
	`value` INT
);

DROP TABLE IF EXISTS `test2`;
CREATE TABLE IF NOT EXISTS `test2` (
	`id` INT,
	`value` INT
);

INSERT INTO `test1` VALUES (1, 1), (2, 2);
INSERT INTO `test2` VALUES (1, NULL), (2, NULL);

SELECT '> test2' AS " ";
SELECT * FROM test2;

UPDATE `test2`
INNER JOIN `test1` ON `test1`.`id` = `test2`.`id`
SET `test2`.`value` = `test1`.`value`
-- SET `test2`.`value` = if(`tablea`.`value` > 0, `tablea`.`value`, `tableb`.`value`)
WHERE `test2`.`id` = 1;

SELECT '> test2 после UPDATE join' AS " ";
SELECT * FROM `test2`;

UPDATE `test2`
INNER JOIN (
	SELECT *
	FROM `test1`
) AS `t1` ON `t1`.`id` = `test2`.`id`
SET `test2`.`value` = `t1`.`value`;

SELECT '> test2 после UPDATE join SELECT' AS " ";
SELECT * FROM `test2`;

SELECT '> Из данных на руках в test2' AS " ";
CREATE TEMPORARY TABLE `mydata` (
  `id` INT,
  `value` INT
);

INSERT INTO `mydata` VALUES
(1, 100),
(2, 200);

UPDATE `test2`
INNER JOIN `mydata` `d` ON `d`.`id` = `test2`.`id`
SET `test2`.`value` = `d`.`value`;

SELECT * FROM `test2`;
