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
