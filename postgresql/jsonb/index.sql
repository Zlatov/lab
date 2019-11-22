DROP TABLE IF EXISTS a;

CREATE TABLE a (
  a_id serial PRIMARY KEY,
  jdata jsonb
);

CREATE OR REPLACE FUNCTION a(vcount integer) RETURNS VOID AS
$$
BEGIN
  FOR i IN 1..vcount LOOP
    INSERT INTO a VALUES (DEFAULT, '{}');
  END LOOP;
END
$$ LANGUAGE plpgsql;


SELECT a(100000);
INSERT INTO a VALUES (DEFAULT, '{"id": 8, "asd": {"id": 9}}');
SELECT a(100000);

-- EXPLAIN SELECT * FROM a WHERE jdata @> '{"id": 8}';
EXPLAIN ANALYZE SELECT * FROM a WHERE (jdata -> 'asd') @> '{"id": 9}';

-- CREATE INDEX ON a USING GIN(jdata);
-- CREATE INDEX ON a USING GIN(jdata jsonb_path_ops);
-- CREATE INDEX ON a USING GIN((jdata->'asd'));
CREATE INDEX ON a USING GIN((jdata->'asd') jsonb_path_ops);

-- EXPLAIN SELECT * FROM a WHERE jdata @> '{"id": 8}';
EXPLAIN ANALYZE SELECT * FROM a WHERE (jdata -> 'asd') @> '{"id": 9}';

SELECT count(*) FROM a;

-- Выводы
-- 1. Лучше индексировать отдельное поле с хэшем в котором будут поисковые поля
-- 2. создание индекса с jsonb_path_ops работает почуму-то быстрее
