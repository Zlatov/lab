DROP TABLE IF EXISTS a;
DROP TABLE IF EXISTS b;
CREATE TABLE a (
  id SERIAL PRIMARY KEY
);
CREATE TABLE b (
  a_id INT NOT NULL,
  g_id INT NOT NULL
);
CREATE INDEX ix_b_aid ON b (a_id);

INSERT INTO a VALUES
(DEFAULT),
(DEFAULT);

INSERT INTO b VALUES
(1, 10),
(1, 10),
(2, 10),
(2, 10);

SELECT * FROM a;
SELECT * FROM b;

SELECT *
FROM a
LEFT JOIN b on b.a_id = a.id
;

SELECT
  a.*,
  sum(b.g_id)
FROM a
LEFT JOIN b on b.a_id = a.id
GROUP BY a.id
;
