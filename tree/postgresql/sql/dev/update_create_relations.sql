\i ../tables.sql
\i ../triggers.sql

DELETE FROM tree_rel;
DELETE FROM tree;
ALTER SEQUENCE tree_id_seq START 1;
INSERT INTO tree (pid) VALUES (NULL), (1), (2), (3), (4), (NULL), (6);
\set moved_id 3
\set new_pid 7

SELECT 'Начальные данные' AS " ";
SELECT * FROM tree ORDER BY id, pid;
SELECT * FROM tree_rel ORDER BY aid, did;

SELECT a.aid, b.did
FROM (
  SELECT r1.aid
  FROM tree_rel r1
  WHERE r1.did = :new_pid AND r1.aid <> :moved_id
) AS a
CROSS JOIN (
  SELECT r1.did
  FROM tree_rel r1
  WHERE r1.aid = :moved_id
) AS b;

UPDATE tree SET pid = :new_pid WHERE id = :moved_id;

SELECT 'Получилось №1' AS " ";
SELECT * FROM tree ORDER BY id, pid;
SELECT * FROM tree_rel ORDER BY aid, did;
