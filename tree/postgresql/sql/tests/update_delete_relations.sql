-- ┌─┬─┐│ │ │├─┼─┤│ │ │└─┴─┘

\i ../tables.sql
\i ../triggers.sql

-- BEGIN;

DELETE FROM tree_rel;
DELETE FROM tree;
ALTER SEQUENCE tree_id_seq START 1;
INSERT INTO tree (pid) VALUES (NULL), (1), (2), (3), (4), (NULL);
SELECT 'Начальные данные' AS " ";
SELECT * FROM tree_rel ORDER BY aid, did;
-- aid | did
--   1 |   2
--   1 |   3-
--   1 |   4--
--   1 |   5--
--   2 |   3-
--   2 |   4--
--   2 |   5--
--   3 |   4
--   3 |   5
--   4 |   5
-- Должно остаться
--   1 |   2
--   3 |   4
--   3 |   5
--   4 |   5


\set moved_id 3
-- UPDATE tree SET pid = 6 WHERE :moved_id = 3;

SELECT 'Что будет удалено' AS " ";
SELECT *
FROM tree_rel descendants -- descendants.did это id потомков (descendants.aid = OLD.id)
LEFT JOIN tree_rel descendant_ancestors ON descendant_ancestors.did = descendants.did -- descendant_ancestors.aid это id предков потомков ()
INNER JOIN tree_rel r ON r.did = :moved_id
  AND (
    r.aid = descendant_ancestors.aid
    -- OR descendant_ancestors.aid = :moved_id
  )
WHERE descendants.aid = :moved_id;

DELETE
FROM tree_rel tr
USING (
  SELECT descendant_ancestors.*
  FROM tree_rel descendants -- descendants.did это id потомков (descendants.aid = OLD.id)
  LEFT JOIN tree_rel descendant_ancestors ON descendant_ancestors.did = descendants.did -- descendant_ancestors.aid это id предков потомков ()
  LEFT JOIN tree_rel r ON r.did = :moved_id
    AND r.aid = descendant_ancestors.aid
    -- AND (
    --   r.aid = descendant_ancestors.aid
    --   -- OR descendant_ancestors.aid = :moved_id
    -- )
  WHERE descendants.aid = :moved_id
) AS rels
WHERE tr.aid = rels.aid AND tr.did = rels.did;

SELECT 'Получилось №1' AS " ";
SELECT * FROM tree_rel ORDER BY aid, did;
\q








DELETE FROM tree_rel;
DELETE FROM tree;
ALTER SEQUENCE tree_id_seq RESTART WITH 1;
INSERT INTO tree (pid) VALUES (NULL), (1), (2), (3), (4), (NULL);

SELECT 'Что будет удалено' AS " ";
SELECT *
FROM (
  SELECT aid
  FROM tree_rel
  WHERE did = :moved_id
) AS a
CROSS JOIN (
  SELECT did
  FROM tree_rel
  WHERE aid = :moved_id
  UNION ALL SELECT :moved_id
) AS b;

DELETE
FROM tree_rel tr
USING (
  SELECT *
  FROM (
    SELECT aid
    FROM tree_rel
    WHERE did = :moved_id
  ) AS a
  CROSS JOIN (
    SELECT did
    FROM tree_rel
    WHERE aid = :moved_id
    UNION ALL SELECT :moved_id
  ) AS b
) AS rel
WHERE tr.aid = rel.aid AND tr.did = rel.did;

SELECT 'Получилось №2' AS " ";
SELECT * FROM tree_rel ORDER BY aid, did;

-- COMMIT;
