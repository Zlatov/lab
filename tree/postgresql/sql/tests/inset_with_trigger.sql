\i ../tables.sql
\i ../triggers.sql

INSERT INTO tree (pid) VALUES
(NULL),
(1);
SELECT * FROM tree;
SELECT * FROM tree_rel;