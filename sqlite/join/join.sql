DROP TABLE IF EXISTS `a`;
DROP TABLE IF EXISTS `b`;

CREATE TABLE `a` (
  `a_id` INT UNSIGNED NOT NULL,
  `a_name` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`a_id`)
);

CREATE TABLE `b` (
  `b_id` INT UNSIGNED NOT NULL,
  `b_name` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`b_id`)
);

INSERT INTO `a` VALUES (1,'1'), (2,'2');
INSERT INTO `b` VALUES (1,'1'), (3,'3');

select 
	ifnull(full_outer_join_ab.a_id, full_outer_join_ab.b_id) as id,
	full_outer_join_ab.a_name,
	full_outer_join_ab.b_name
from (
	SELECT a.*, b.*
	FROM a a
	LEFT JOIN b b on b.b_id = a.a_id
	UNION ALL
	SELECT a.*, b.*
	FROM b b
	LEFT JOIN a a on b.b_id = a.a_id
	WHERE a.a_id IS NULL
) full_outer_join_ab;
