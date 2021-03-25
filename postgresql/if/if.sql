-- Пример с CASE
SELECT 'CASE такая вот штука:' AS " ";
SELECT
  a.a,
  a.b,
  CASE
    WHEN a.a IS NULL THEN 0
    WHEN a.b = 1 THEN 2
    ELSE 3
  END AS "a or b"
FROM (
  SELECT
    NULL::int AS "a",
    1::int AS "b"
) AS a
;

-- Пример с COALESCE
-- Возвращает первый попавшийся аргумент, отличный от NULL. Если же все
-- аргументы равны NULL, результатом тоже будет NULL.
SELECT 'COALESCE:' AS " ";
SELECT COALESCE("a", "b", 'default') AS "a or b or 'default'"
FROM (
  SELECT
    NULL::varchar(255) AS "a",
    NULL::varchar(255) AS "b"
) "a";
SELECT COALESCE("a", "b", 100) AS "a or b or 100"
FROM (
  SELECT
    NULL::int AS "a",
    3::int AS "b"
) "a";
-- \q


-- Пример с NULLIF
SELECT 'NULLIF:' AS " ";
SELECT NULLIF(a.a, '')
FROM (
  SELECT
    ''::varchar(255) AS "a"
) AS a;

SELECT 'SELECT:' AS " ";
SELECT 1;
SELECT NULL;
SELECT 1 + 1;
SELECT 1 + NULL;
