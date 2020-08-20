DROP TABLE IF EXISTS a;
DROP TABLE IF EXISTS b;
CREATE TABLE a (
  a_id INT PRIMARY KEY
);
CREATE TABLE b (
  b_id INT PRIMARY KEY
);

BEGIN;

INSERT INTO a VALUES (1), (3);
INSERT INTO b VALUES (2), (3);

-- 
-- В SQL есть Внутреннее объединение, Внешние объединения и Перекрёстное объединение таблиц.
-- 
-- Внутреннее объединение — то что есть и в левой и в правой таблице одновременно (соответствие).
-- 
-- Внешние объединения — например,
-- к строке левой таблицы присоединяется строка правой таблицы если есть соответствие и присоединяется NULL если соответствия нет.
-- Три внешних объединения: LEFT, RIGHT и FULL.
-- 
-- Перекрёстное объединение — есть перемножение таблиц, без соответствия, например,
-- к каждой строке левой таблицы присоединяется каждая строка правой таблицы.
-- 

select 'INNER JOIN (внутреннее объединение)' as " ";
select * from a INNER JOIN b on b.b_id = a.a_id;

select 'LEFT OUTER JOIN | LEFT JOIN' as " ";
select * from a LEFT JOIN b on b.b_id = a.a_id;
select * from a LEFT OUTER JOIN b on b.b_id = a.a_id;

select 'RIGHT OUTER JOIN | RIGHT JOIN' as " ";
select * from a RIGHT JOIN b on b.b_id = a.a_id;
select * from a RIGHT OUTER JOIN b on b.b_id = a.a_id;

select 'FULL OUTER JOIN' as " ";
select * from a LEFT JOIN b on b.b_id = a.a_id
UNION
select * from a RIGHT JOIN b on b.b_id = a.a_id;
-- или
select * from a FULL OUTER JOIN b on b.b_id = a.a_id;

select 'CROSS JOIN' as " ";
select * from a CROSS JOIN b;

select 'FROM' as " ";
select * from a, b;
-- \q


-- Варианты объединения:
--   A   B
-- ┌──┬─┬──┐
-- │▓▓│▓│░░│
-- └──┴─┴──┘
select '▓▓│▓│░░' as " ";
select *
from a
LEFT JOIN b on a.a_id = b.b_id;
--   A   B
-- ┌──┬─┬──┐
-- │▓▓│░│░░│
-- └──┴─┴──┘
select '▓▓│░│░░' as " ";
select *
from a
LEFT JOIN b on a.a_id = b.b_id
WHERE b.b_id IS NULL;
--   A   B
-- ┌──┬─┬──┐
-- │░░│▓│▓▓│
-- └──┴─┴──┘
select '░░│▓│▓▓' as " ";
select *
from a
RIGHT JOIN b on a.a_id = b.b_id;
--   A   B
-- ┌──┬─┬──┐
-- │░░│░│▓▓│
-- └──┴─┴──┘
select '░░│░│▓▓' as " ";
select *
from a
RIGHT JOIN b on a.a_id = b.b_id
WHERE a.a_id IS NULL;
--   A   B
-- ┌──┬─┬──┐
-- │░░│▓│░░│
-- └──┴─┴──┘
select '░░│▓│░░' as " ";
select *
from a
INNER JOIN b on a.a_id = b.b_id;
--   A   B
-- ┌──┬─┬──┐
-- │▓▓│▓│▓▓│
-- └──┴─┴──┘
select '▓▓│▓│▓▓' as " ";
select *
from a
FULL JOIN b on a.a_id = b.b_id;
--   A   B
-- ┌──┬─┬──┐
-- │▓▓│░│▓▓│
-- └──┴─┴──┘
select '▓▓│░│▓▓' as " ";
select *
from a
FULL JOIN b on a.a_id = b.b_id
WHERE a.a_id IS NULL OR b.b_id IS NULL;

COMMIT;
