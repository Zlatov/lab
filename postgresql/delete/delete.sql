-- DELETE FROM films USING producers
--   WHERE producer_id = producers.id AND producers.name = 'foo';
-- -- Удаление всех фильмов, кроме мюзиклов:
-- DELETE FROM films WHERE kind <> 'Musical';
-- -- Очистка таблицы films:
-- DELETE FROM films;
-- -- Удаление завершённых задач с получением всех данных удалённых строк:
-- DELETE FROM tasks WHERE status = 'DONE' RETURNING *;
-- -- Удаление из tasks строки, на которой в текущий момент располагается курсор c_tasks:
-- DELETE FROM tasks WHERE CURRENT OF c_tasks;

DROP TABLE IF EXISTS a;
DROP TABLE IF EXISTS b;
DROP TABLE IF EXISTS c;
CREATE TABLE a (a_id SERIAL PRIMARY KEY);
CREATE TABLE b (b_id SERIAL PRIMARY KEY);
CREATE TABLE c (c_id SERIAL PRIMARY KEY);

SELECT 'Способ №1. Простой' AS " ";
DELETE FROM a; INSERT INTO a VALUES (DEFAULT),(DEFAULT);
DELETE FROM b; INSERT INTO b VALUES (DEFAULT),(3);
DELETE FROM c; INSERT INTO c VALUES (DEFAULT),(4);

DELETE FROM a WHERE a_id = 1;
SELECT * FROM a;
-- \q

SELECT 'Способ №2. USING' AS " ";
DELETE FROM a; INSERT INTO a VALUES (1),(2);
DELETE FROM b; INSERT INTO b VALUES (1),(3);
DELETE FROM c; INSERT INTO c VALUES (1),(4);

DELETE
FROM a
USING b
WHERE
  a.a_id = b.b_id
  AND b.b_id = 1;
SELECT * FROM a;
-- \q

SELECT 'Способ №3. WITH qwe AS(…) DELETE USING qwe WHERE…' AS " ";
DELETE FROM a; INSERT INTO a VALUES (1),(2);
DELETE FROM b; INSERT INTO b VALUES (1),(3);
DELETE FROM c; INSERT INTO c VALUES (1),(4);

SELECT b.*
FROM b
INNER JOIN c ON c.c_id = b.b_id
WHERE b.b_id = c.c_id;

WITH for_del AS (
  SELECT b.*
  FROM b
  INNER JOIN c ON c.c_id = b.b_id
  WHERE b.b_id = c.c_id
)
DELETE
FROM a
USING for_del
WHERE a.a_id = for_del.b_id;
SELECT * FROM a;
-- \q

SELECT 'Способ №4. DELETE FROM qwe USING (…) AS asd WHERE…' AS " ";
DELETE FROM a; INSERT INTO a VALUES (1),(2);
DELETE FROM b; INSERT INTO b VALUES (1),(3);
DELETE FROM c; INSERT INTO c VALUES (1),(4);

DELETE
FROM a
USING (
  SELECT *
  FROM b
  WHERE b.b_id = 1
) AS bb
WHERE a.a_id = bb.b_id;

SELECT * FROM a;
