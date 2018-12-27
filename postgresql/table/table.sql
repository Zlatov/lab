
SELECT table_schema, table_name
FROM information_schema.tables
ORDER BY table_schema, table_name;


DROP TABLE IF EXISTS lorem;
DROP TABLE IF EXISTS lorem;
CREATE TABLE lorem (
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  age INT NOT NULL,
  address CHAR(50),
  salary REAL
);

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
