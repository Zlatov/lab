-- Нормальное перемащение
\i ../tables.sql
\i ../triggers.sql


INSERT INTO tree (pid) VALUES
(NULL), -- 1
(1),    -- 2
(2),    -- 3
(NULL); -- 4
SELECT * FROM tree;
SELECT * FROM tree_rel ORDER BY aid;

BEGIN;
UPDATE tree SET pid = 4 WHERE id = 2;
COMMIT;

SELECT * FROM tree;
SELECT * FROM tree_rel ORDER BY aid, did;
