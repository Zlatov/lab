\i ../tables.sql
\i ../triggers.sql

INSERT INTO tree (pid) VALUES
(NULL), -- 1
(1),    -- 2
(2),    -- 3
(3),    -- 4
(NULL), -- 5
(3);    -- 6

SELECT * FROM tree;
SELECT * FROM tree_rel ORDER BY aid, did;
