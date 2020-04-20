-- DROP TABLE [IF EXISTS] table_name [CASCADE | RESTRICT];
DROP TABLE IF EXISTS users CASCADE;
-- DROP SEQUENCE [ IF EXISTS ] name [, ...] [ CASCADE | RESTRICT ]
DROP SEQUENCE IF EXISTS user_ids CASCADE;

CREATE SEQUENCE user_ids;

CREATE TABLE users (
  id INTEGER PRIMARY KEY DEFAULT NEXTVAL('user_ids'),
  login CHAR(64),
  password CHAR(64)
);

\d
\d users

SELECT '> min max' as " ";
DROP TABLE IF EXISTS a;
CREATE TABLE a (
  id SERIAL PRIMARY KEY,
  price DECIMAL(11, 2)
);
CREATE INDEX ix_a_id ON a (id);
CREATE INDEX ix_a_price ON a (price);
INSERT INTO a VALUES
(DEFAULT, 11),
(DEFAULT, 12),
(DEFAULT, 13);
SELECT MIN(a.price), MAX(a.price) FROM a;
-- \q
