DROP TABLE `count_unique`;
CREATE TABLE IF NOT EXISTS `count_unique` (
	`numbers` INT,
	`string` VARCHAR(255)
);

INSERT INTO `count_unique` VALUES
(1, 'a'),
(2, 'c'),
(3, 'b'),
(4, 'b'),
(5, 'a'),
(6, 'b'),
(7, 'c');

SELECT * FROM `count_unique`;

SELECT `string`, count(`numbers`)
FROM `count_unique`
GROUP BY `string`
