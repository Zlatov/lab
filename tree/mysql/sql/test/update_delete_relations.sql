source /home/iadfeshchm/projects/my/lab/tree/mysql/sql/tables.sql;
source /home/iadfeshchm/projects/my/lab/tree/mysql/sql/triggers.sql;

INSERT INTO tree (pid) VALUES
(NULL),
  (1),
    (2),
      (3),
(NULL);

SELECT * FROM tree_rel;
--  aid | did 
--    1 |   2
--    1 |   3
--    2 |   3
--    1 |   4
--    2 |   4
--    3 |   4


SET @OLD_id = 3;
-- UPDATE tree SET pid = 5 WHERE id = 3;

--  aid | did 
--    1 |   2
--    1 |   3 -
--    2 |   3 -
--    1 |   4 --
--    2 |   4 --
--    3 |   4

SELECT *
FROM tree_rel descendants -- descendants.did это id потомков (descendants.aid = OLD.id)
LEFT JOIN tree_rel descendant_ancestors ON descendant_ancestors.did = descendants.did -- descendant_ancestors.aid это id предков потомков ()
INNER JOIN tree_rel r ON r.did = @OLD_id AND r.aid = descendant_ancestors.aid
WHERE descendants.aid = @OLD_id;
