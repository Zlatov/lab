\c lab

DROP TABLE IF EXISTS a;

CREATE TABLE a (
  a_id SERIAL PRIMARY KEY,
  data jsonb
);

INSERT INTO a VALUES
(DEFAULT,  '[null, null, 1]'),
(DEFAULT,  '{"a": null, "asd": 2}');

SELECT * FROM a;
\q

SELECT '> JSON::json -> INT' as " ";
SELECT data::json -> 2 as "a" FROM a WHERE a_id = 1;

SELECT '> JSON::json -> STR' as " ";
SELECT data::json -> 'asd' FROM a WHERE a_id = 2;
