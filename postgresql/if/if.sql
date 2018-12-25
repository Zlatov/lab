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
SELECT 'COALESCE:' AS " ";
SELECT COALESCE(a.a, a.b, '(none)') AS "a or b or (none)"
FROM (
  SELECT
    NULL::varchar(255) AS "a",
    NULL::varchar(255) AS "b"
) AS a;


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
