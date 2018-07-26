-- Выбрать список таблиц БД
-- SHOW tables;

-- Создать таблицу
-- CREATE TABLE `test` (`numbers` INT);
-- CREATE TABLE IF NOT EXISTS `test` (`numbers` INT);

SHOW tables;
CREATE TABLE IF NOT EXISTS `test` (`numbers` INT);
SHOW tables;
DROP TABLE `test`;
SHOW tables;

DROP TABLE IF EXISTS `lorem`;
CREATE TABLE IF NOT EXISTS `lorem` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `sid` VARCHAR(255) NOT NULL COMMENT 'Строковый идентификатор.',
  `key` VARCHAR(64) NOT NULL,
  `hash` VARCHAR(64) NOT NULL,
  `not_unique_on_null` VARCHAR(64) NULL COMMENT 'Проверить что уникальность не влияет на NULL',
  `numbers` INT,
  `header` VARCHAR(161) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE INDEX `uq_lorem_sid` (`sid`),
  INDEX `uq_lorem_hash` (`hash`) COMMENT 'не уникальное поле с индексацией',
  UNIQUE KEY `uq_lorem_key` (`key`) COMMENT 'уникальное поле без индексации',
  UNIQUE KEY `uq_lorem_notuniqueonnull` (`not_unique_on_null`)
)
ENGINE InnoDB
AUTO_INCREMENT 1
DEFAULT CHARACTER SET utf8
COLLATE utf8_general_ci;

SHOW tables;

-- Проверка не уникального поля с индексацией hash
insert into `lorem` (`sid`, `key`, `hash`) values
('1', '1', '3'),
('2', '2', '3'),
('3', '3', '4'),
('4', '4', '4');
EXPLAIN `lorem`;
EXPLAIN
SELECT *
FROM `lorem`
WHERE `hash` = '4';

-- Проверка на то что уникальность не влияет на NULL
delete from lorem;
insert into `lorem` (`sid`, `key`, `hash`, `not_unique_on_null`) values
('1', '1', '3', NULL),
('2', '2', '3', NULL),
('3', '3', '4', '1'),
('4', '4', '4', '2'),
('5', '5', '5', NULL);

select * from `lorem`;
