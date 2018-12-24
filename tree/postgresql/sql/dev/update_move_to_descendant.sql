-- Перемащение в потомка
\i ../tables.sql
\i ../triggers.sql

BEGIN;

INSERT INTO tree (pid) VALUES
(NULL),
(1),
(2),
(3);

SELECT * FROM tree WHERE id=2;
SELECT * FROM tree_rel;
UPDATE tree SET pid = 3 WHERE id = 2;
SELECT * FROM tree WHERE id=2;
SELECT * FROM tree_rel;
COMMIT;
