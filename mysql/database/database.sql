-- Просмотреть список соществующих баз данных.
SHOW databases;
exit

-- Удалить базу данных
DROP DATABASE IF EXISTS `lab`;
-- Создать базу данных
CREATE SCHEMA `lab` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;

-- Выбрать базу данных
USE lab;

-- Определить выбранную БД
SELECT DATABASE();

SHOW databases;
USE `lab`;
SELECT DATABASE();
SHOW tables;
