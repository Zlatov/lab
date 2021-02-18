DROP TABLE IF EXISTS `a`;
CREATE TABLE `a` (
  `int` INT UNSIGNED NOT NULL
);


INSERT INTO `a` (`int`) VALUES
(1464347700),
(1464347703),
(1464347701)
;

select * from a;

SELECT
  `int`,
  FROM_UNIXTIME(`int`) AS `date`,
  FROM_UNIXTIME(UNIX_TIMESTAMP(), '%Y %D %M %h:%i:%s %x') AS `date2`
FROM a
ORDER BY `int`
;
