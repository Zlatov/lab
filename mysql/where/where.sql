DROP TABLE IF EXISTS `a`;

CREATE TABLE `a` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT, 
  `string` VARCHAR(255) NOT NULL DEFAULT '',
  `boolean` TINYINT(1) NOT NULL DEFAULT false,
  PRIMARY KEY (`id`)
);

INSERT INTO `a` (`string`, `boolean`) VALUES
('1', 0),
('2', 1),
('2', 0),
('3', 1);

SELECT *
FROM `a`
-- WHERE string = '2'
-- WHERE string = '2' OR string = '3'
-- WHERE string IN ('2', '3')
-- WHERE string NOT IN ('2', '3')

-- WHERE string = '2' AND boolean = true
;
