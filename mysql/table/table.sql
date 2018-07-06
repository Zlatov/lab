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

CREATE TABLE IF NOT EXISTS `lorem` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `numbers` INT,
  `header` VARCHAR(161) NOT NULL,
  PRIMARY KEY (`id`)
  -- TODO lorem!!!
)
ENGINE InnoDB
AUTO_INCREMENT 1
DEFAULT CHARACTER SET utf8
COLLATE utf8_general_ci;

SHOW tables;
