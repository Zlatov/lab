DROP TABLE IF EXISTS `temp`;

CREATE TABLE `temp` (
	`f1` TINYINT(1) NOT NULL,
	`f2` TINYINT(1) NOT NULL DEFAULT 0,
	`f3` TINYINT(1) NOT NULL DEFAULT true
);

SHOW FULL FIELDS FROM `temp`;

INSERT INTO
	`temp` (`f1`)
VALUES
	(0),
	(1),
	(false),
	(true);

SELECT * FROM `temp`;
