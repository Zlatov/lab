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
  `tag` VARCHAR(64) NOT NULL DEFAULT 'def',
  `type` ENUM("int", "str", "flo") NULL DEFAULT 'flo',
  `numbers` INT,
  `header` VARCHAR(161) NOT NULL,
  `infoid` VARCHAR(64) NULL COMMENT 'Проверить что уникальность не влияет на NULL',
  PRIMARY KEY (`id`),
  INDEX        `ix_lorem_tag` (`tag`)       COMMENT 'индексное поле без ограничения на уникальность',
  UNIQUE INDEX `uq_lorem_sid` (`sid`)       COMMENT 'уникальное поле с индексацией',
  UNIQUE KEY   `uq_lorem_header` (`header`) COMMENT 'уникальное поле без индексации',
  UNIQUE KEY   `uq_lorem_infoid` (`infoid`)
)
ENGINE InnoDB
AUTO_INCREMENT 1
DEFAULT CHARACTER SET utf8
COLLATE utf8_general_ci;
-- NNND: sid key header
-- UQ: sid header infoid
--  : sid key header

SHOW tables;

-- Проверка не уникального поля с индексацией: tag
insert into `lorem` (`sid`, `key`, `header`, `tag`) values
('1', '1', '1', '3'),
('2', '2', '2', '3'),
('3', '3', '3', '4'),
('4', '4', '4', '4');
EXPLAIN `lorem`;
EXPLAIN
SELECT *
FROM `lorem`
WHERE `tag` = '4';

-- Проверка на то что уникальность не влияет на NULL
delete from lorem;
insert into `lorem` (`sid`, `key`, `header`, `infoid`) values
('1', '1', '1', NULL),
('2', '2', '2', NULL),
('3', '3', '3', '1'),
('4', '4', '4', '2'),
('5', '5', '5', NULL);

select * from `lorem`;
