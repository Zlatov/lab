-- Нормальное перемащение
\i ../tables.sql
\i ../triggers.sql

INSERT INTO tree (pid) VALUES
(NULL),
(1),
(2),
(NULL);
-- SELECT * FROM tree;
SELECT * FROM tree_rel;

UPDATE tree SET pid = 4 WHERE id = 2;
SELECT * FROM tree_rel;
