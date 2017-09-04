DROP TABLE IF EXISTS `test`;

CREATE TABLE `test` (
	`id` INT unsigned NOT NULL auto_increment,
	`n` INT unsigned,
	PRIMARY KEY (`id`)
)
engine=innodb
auto_increment 1
DEFAULT charset=utf8
COLLATE utf8_general_ci;

INSERT INTO `test` (`n`) VALUES (1),(1),(2),(3),(3);

SELECT 'Начальные данные' as '===============================';
SELECT * FROM test;


-- SELECT
-- 	t2.*
-- FROM
-- 	(
-- 		SELECT t.n, count(t.n) AS count_dupl
-- 		FROM test t
-- 		GROUP BY t.n
-- 		HAVING count_dupl > 1
-- 	) AS t
-- LEFT JOIN test t2 ON t2.n = t.n;

DELETE
	t2.*
FROM
	(
		SELECT t.n, count(t.n) AS count_dupl
		FROM test t
		GROUP BY t.n
		HAVING count_dupl > 1
	) AS t
LEFT JOIN test t2 ON t2.n = t.n;

-- ```delete from test where id IN (select ...``` - 
-- ограничено лишь max_allowed_packet, так что можно и через IN

SELECT 'Результат' as '===============================';
SELECT * FROM test;
