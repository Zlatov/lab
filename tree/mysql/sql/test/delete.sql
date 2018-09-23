USE lab;
source /home/iadfeshchm/projects/my/lab/tree/mysql/sql/tables.sql;
source /home/iadfeshchm/projects/my/lab/tree/mysql/sql/triggers.sql;

INSERT INTO tree (id, pid, header)
VALUES
(1,  NULL, '1'),
(2,     1, '2'),
(3,     2, '3'),
(4,     3, '4'),
(5,     4, '5'),
(6,     5, '6');

-- SELECT COUNT(aid) = 10 as test FROM tree_rel;

DELETE FROM tree WHERE id = 4;

SELECT COUNT(aid) = 3 as test_count_relations_after_delete FROM tree_rel;
