DROP TABLE `count_unique`;
CREATE TABLE IF NOT EXISTS `count_unique` (
	`numbers` INT,
	`string` VARCHAR(255)
);

INSERT INTO `count_unique` VALUES
(1, 'яблоки'),
(2, 'бананы'),
(3, 'груши'),
(4, 'груши'),
(5, 'яблоки'),
(6, 'груши'),
(7, 'что-то чего не должно быть'),
(8, 'бананы');

-- SELECT * FROM `count_unique`;

SELECT `string`, count(`numbers`)
FROM `count_unique`
GROUP BY `string`;

-- Неправильный подход к программированию в SQL:
-- SELECT
-- 	b.string
-- 	,b.numbers
-- 	,c.numbers
-- 	-- ,d.numbers
-- FROM (
-- 	SELECT
-- 		distinct a.string,
-- 		a.numbers,
-- 		count(a.numbers) as count
-- 	FROM count_unique a
-- 	GROUP BY a.string
-- 	HAVING count > 1
-- ) as b
-- LEFT JOIN count_unique c ON c.string = b.string AND c.numbers <> b.numbers
-- LEFT JOIN count_unique d ON d.string = c.string AND d.numbers <> c.numbers

SELECT
	a.string,
	a.numbers,
	b.numbers
FROM count_unique a, count_unique b
WHERE
	a.numbers <> b.numbers
	AND a.string = b.string
GROUP BY a.string, a.numbers + b.numbers
