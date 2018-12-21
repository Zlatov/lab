\i ../tables.sql
\i ../triggers.sql

-- Тест рекурсивного удаления
INSERT INTO tree (pid) VALUES
(NULL),
(1);
SELECT * FROM tree;
DELETE FROM tree WHERE id = 1;
SELECT * FROM tree;
-- Тест рекурсивного обновления
INSERT INTO tree (pid) VALUES
(NULL),
(3);
SELECT * FROM tree;
UPDATE tree SET id = 6 WHERE id = 3;
SELECT * FROM tree;
