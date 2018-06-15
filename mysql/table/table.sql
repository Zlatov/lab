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

-- TODO
CREATE TABLE IF NOT EXISTS `lorem` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `numbers` INT,
  `header` VARCHAR(160) NOT NULL,
);
