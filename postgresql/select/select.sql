\c lab
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

SELECT '> Вывод всех таблиц БД' as " ";
\d

SELECT '> Вывод колонок таблицы БД' as " ";
\d users
-- \q

SELECT '> Выбор минимального и максимального значения в поля MIN(filed) MAX(filed)' as " ";
DROP TABLE IF EXISTS a;
CREATE TABLE a (
  id SERIAL PRIMARY KEY,
  price DECIMAL(11, 2),
  old_price DECIMAL(11, 2)
);
CREATE INDEX ix_a_id ON a (id);
CREATE INDEX ix_a_price ON a (price);
INSERT INTO a (id, price, old_price) VALUES
(DEFAULT, 11, 10),
(DEFAULT, 12, 10),
(DEFAULT, 13, 10);
SELECT MIN(a.price), MAX(a.price) FROM a;
-- \q

SELECT '> Условие по типу IF(condition, field1, field2) реализуется в postgres оператором CASE' as " ";
SELECT
  price,
  old_price,
  CASE WHEN a.id = 1 THEN old_price ELSE price END AS current_price
FROM a;
-- \q

SELECT '> Генерация uuid gen_random_uuid()' as " ";
SELECT gen_random_uuid();
-- \q
