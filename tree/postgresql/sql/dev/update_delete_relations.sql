\i ../tables.sql
\i ../triggers.sql

-- BEGIN;

DELETE FROM tree_rel;
DELETE FROM tree;
ALTER SEQUENCE tree_id_seq RESTART 1;
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
-- \q

\set moved_id 3
-- UPDATE tree SET pid = 6 WHERE id = 3;

SELECT 'Что будет удалено' AS " ";
SELECT *
FROM tree_rel r1 -- потомки
INNER JOIN tree_rel r2 ON r2.did = r1.did -- предки потомков, связи в том числе потомков с потомками, поэтому далее:
INNER JOIN tree_rel r3 ON r3.did = :moved_id AND r3.aid <> :moved_id -- чистые предки, позволят удалить связи потомков с потомками
  AND r3.aid = r2.aid
WHERE r1.aid = :moved_id;
-- \q

DELETE
FROM tree_rel tr
USING (
  SELECT r2.aid, r2.did
  FROM tree_rel r1 -- потомки
  INNER JOIN tree_rel r2 ON r2.did = r1.did -- предки потомков, связи в том числе потомков с потомками, поэтому далее:
  INNER JOIN tree_rel r3 ON r3.did = :moved_id AND r3.aid <> :moved_id -- чистые предки, позволят удалить связи потомков с потомками
    AND r3.aid = r2.aid
  WHERE r1.aid = :moved_id
) AS rels
WHERE tr.aid = rels.aid AND tr.did = rels.did;

SELECT 'Получилось №1' AS " ";
SELECT * FROM tree_rel ORDER BY aid, did;
-- \q








DELETE FROM tree_rel;
DELETE FROM tree;
ALTER SEQUENCE tree_id_seq RESTART WITH 1;
INSERT INTO tree (pid) VALUES (NULL), (1), (2), (3), (4), (NULL);

SELECT 'Что будет удалено' AS " ";
SELECT *
FROM (
  SELECT aid
  FROM tree_rel
  WHERE did = :moved_id AND aid != :moved_id
) AS a
CROSS JOIN (
  SELECT did
  FROM tree_rel
  WHERE aid = :moved_id
) AS b;

DELETE
FROM tree_rel tr
USING (
  SELECT *
  FROM (
    SELECT aid
    FROM tree_rel
    WHERE did = :moved_id AND aid != :moved_id
  ) AS a
  CROSS JOIN (
    SELECT did
    FROM tree_rel
    WHERE aid = :moved_id
  ) AS b
) AS rel
WHERE tr.aid = rel.aid AND tr.did = rel.did;

SELECT 'Получилось №2' AS " ";
SELECT * FROM tree_rel ORDER BY aid, did;

-- COMMIT;
