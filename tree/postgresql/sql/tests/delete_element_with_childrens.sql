\i ../tables.sql
\i ../triggers.sql

-- Тест рекурсивного удаления
INSERT INTO tree (pid) VALUES
(NULL),
(1);

SELECT 'Начальные данные' AS " ";
SELECT * FROM tree;
SELECT * FROM tree_rel;

DELETE FROM tree WHERE id = 1;

SELECT 'Получилось' AS " ";
SELECT * FROM tree;
SELECT * FROM tree_rel;

DELETE FROM tree_rel;
DELETE FROM tree;
ALTER SEQUENCE tree_id_seq RESTART 1;
INSERT INTO tree (pid) VALUES (NULL), (1), (2), (3), (4);

SELECT 'Начальные данные' AS " ";
SELECT * FROM tree;
SELECT * FROM tree_rel;

DELETE FROM tree WHERE id = 3;

SELECT 'Получилось' AS " ";
SELECT * FROM tree;
SELECT * FROM tree_rel;
