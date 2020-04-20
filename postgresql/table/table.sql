
SELECT table_schema, table_name
FROM information_schema.tables
ORDER BY table_schema, table_name;

SELECT '> таблица a' as " ";
DROP TABLE IF EXISTS a;
CREATE TABLE a (
  id SERIAL PRIMARY KEY
);
CREATE INDEX ix_a_id ON a (id);
INSERT INTO a VALUES
(DEFAULT),
(DEFAULT);
SELECT * FROM a;
-- \q

DROP TABLE IF EXISTS lorem;
DROP TABLE IF EXISTS lorem;
CREATE TABLE lorem (
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL UNIQUE,
  code VARCHAR NULL UNIQUE,
  blue BOOLEAN NOT NULL,
  age INT NOT NULL DEFAULT 18,
  CHECK (age > 0),
  address CHAR(50),
  salary REAL,
  UNIQUE (code, age)
);
CREATE INDEX ix_lorem_unique ON stat_stat (code, age);

-- структура таблицы table.
\d lorem
-- структура таблицы table с описанием.
\d+ lorem
-- список всех таблиц.
\dt
-- список всех таблиц с описанием.
\dt+
-- список всех таблиц, содержащих s в имени.
\dt *s*

INSERT INTO lorem (id, name, blue, code, address) VALUES
(DEFAULT, 'name1', TRUE, NULL, 'address1'),
(DEFAULT, 'name2', TRUE, NULL, 'address1'), -- Может быть две строки с NULL даже если поле UNIQUE так как NULL != NULL - факт.
(DEFAULT, 'name3', FALSE, 'a1', 'address1'),
(DEFAULT, 'name4', FALSE, 'a11', 'address1');

SELECT * FROM lorem LIMIT 4;

SELECT * FROM lorem where "code" IS NULL AND "age" = 18; -- Две записи, хотя code, age - составной уникальный индекс.
