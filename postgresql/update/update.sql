DROP TABLE IF EXISTS a;
DROP TABLE IF EXISTS b;
CREATE TABLE a (a_id SERIAL PRIMARY KEY, name VARCHAR(255));
CREATE TABLE b (b_id SERIAL PRIMARY KEY, name VARCHAR(255));

INSERT INTO a VALUES (DEFAULT, '1'), (DEFAULT, '2');
INSERT INTO b VALUES (DEFAULT, '1'), (DEFAULT, '2');

SELECT * FROM a;
BEGIN;
UPDATE a SET a_id = 3 WHERE a_id = 2;
UPDATE a SET a_id = 2 WHERE a_id = 1;
COMMIT;
SELECT * FROM a;

-- 
-- Обновление из присоединённой таблицы
-- 
-- [ WITH [ RECURSIVE ] with_query [, ...] ]
-- UPDATE [ ONLY ] table_name [ * ] [ [ AS ] alias ]
--     SET { column_name = { expression | DEFAULT } |
--           ( column_name [, ...] ) = [ ROW ] ( { expression | DEFAULT } [, ...] ) |
--           ( column_name [, ...] ) = ( sub-SELECT )
--         } [, ...]
--     [ FROM from_list ]
--     [ WHERE condition | WHERE CURRENT OF cursor_name ]
--     [ RETURNING * | output_expression [ [ AS ] output_name ] [, ...] ]
-- 


-- 
-- Обновление из присоединённой таблицы __по номеру строки__
-- 
UPDATE a
SET name = j.name
FROM (
  select ta.a_id, tb.name
  from (
    select *, ROW_NUMBER() OVER() AS "rn"
    from a
  ) ta
  inner join (
    select *, ROW_NUMBER() OVER() AS "rn" 
    from (
      VALUES
        ('Жиглов Николай'),
        ('Михайлова Юлия'),
        ('Ильясов Виктор'),
        ('Квитко Артур')
    ) temp (name)
  ) tb on tb.rn = ta.rn
) j
WHERE a.a_id = j.a_id
;
SELECT * FROM a;


-- Объединение таблиц (точнее: выборок) по номеру строки.
select *
from (
  select *, ROW_NUMBER() OVER() AS "rn"
  from b
) bb
inner join (
  select *, ROW_NUMBER() OVER() AS "rn"
  from (
    VALUES ('Жиглов Николай'),
    ('Михайлова Юлия'),
    ('Ильясов Виктор'),
    ('Квитко Артур')
  ) temp (name)
) c on c.rn = bb.rn
;
