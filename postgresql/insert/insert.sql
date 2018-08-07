DROP TABLE IF EXISTS table_a;
CREATE TABLE table_a (
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  age INT NOT NULL,
  address CHAR(50),
  salary REAL
);

INSERT INTO table_a (name, age, address, salary) VALUES
('1', 1, '1', 1.0),
('1', 1, '1', 1.0);

SELECT * FROM table_a;
