DROP TABLE IF EXISTS `a`;
DROP TABLE IF EXISTS `b`;

CREATE TABLE `a` (
  `a_id` INT UNSIGNED NOT NULL,
  `a_name` VARCHAR(255) NOT NULL,
  INDEX `ix_a_aid` (`a_id`)
);

CREATE TABLE `b` (
  `b_id` INT UNSIGNED NOT NULL,
  `b_name` VARCHAR(255) NOT NULL,
  INDEX `ix_b_bid` (`b_id`)
);

INSERT INTO `a` VALUES (1,'1'), (2,'2'), (2,'22'), (3,'3');
INSERT INTO `b` VALUES (1,'1'), (3,'3'), (3,'33');

SELECT
  *
FROM a
LEFT JOIN b ON b.b_id = a.a_id
;
-- \q

SELECT '> Применяем агрегатные функции везде где нужно' as " ";
SELECT
  a.a_id,
  MIN(a.a_name),
  b.b_id,
  MAX(b.b_name)
FROM a
LEFT JOIN b ON b.b_id = a.a_id
GROUP BY a.a_id
;
-- \q


-- SELECT
--   a.a_id
--   ,MIN(a.a_name)
--   -- ,b.b_id
--   -- ,b.b_name
-- FROM a
-- LEFT JOIN b ON b.b_id = (
--   SELECT b_id
--   FROM b
--   WHERE b_id = a.a_id
--   LIMIT 1
-- )
-- GROUP BY a.a_id
-- ;


SELECT
  a.a_id
  ,MIN(a.a_name)
  ,bb.b_id
  ,bb.b_name
FROM a
LEFT JOIN (
  SELECT
    DISTINCT b.b_id,
    b.b_name
  FROM b
) bb ON bb.b_id = a.a_id
GROUP BY a.a_id
;
