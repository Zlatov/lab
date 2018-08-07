
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
