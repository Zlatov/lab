\c lab;

DROP TABLE IF EXISTS "values";
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS filters;

-- Продукты
CREATE TABLE products (
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL UNIQUE
);

-- Фильтры
CREATE TABLE filters (
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL UNIQUE,
  slug TEXT NOT NULL UNIQUE
);

-- Значения
CREATE TABLE "values" (
  product_id INTEGER NOT NULL REFERENCES products ON DELETE CASCADE,
  filter_id INTEGER NOT NULL REFERENCES filters ON DELETE CASCADE,
  value NUMERIC(9, 3) NOT NULL,
  num NUMERIC(9, 3),
  str NUMERIC(9, 3),
  PRIMARY KEY (product_id, filter_id)
);
-- CREATE UNIQUE INDEX uq_values_productidfilterid ON "values" (product_id, filter_id);


INSERT INTO filters (id, name, slug) VALUES
(DEFAULT, 'Длина (см)', 'dlina_sm'),
(DEFAULT, 'Частота (Гц)', 'chastota'),
(DEFAULT, 'Цвет', 'cvet');

INSERT INTO products (id, name) VALUES
(DEFAULT, 'product1'),
(DEFAULT, 'product2'),
(DEFAULT, 'product3'),
(DEFAULT, 'product4'),
(DEFAULT, 'product5');

INSERT INTO "values" (product_id, filter_id, value) VALUES
(1, 1, 10),
(2, 1, 20),
(3, 1, 30),
(4, 1, 40),
(5, 1, 50),
(1, 2, 1000),
(2, 2, 2000),
(3, 2, 3000),
(4, 2, 4000);

-- Выбор всего
SELECT '> products' as " ";
SELECT * FROM products;
SELECT '> filters' as " ";
SELECT * FROM filters;
-- \q


-- Выбор отфильтрованный
SELECT '> Выбор отфильтрованный' as " ";
SELECT
  p.*,
  v1.value,
  v2.value
FROM products as p
LEFT JOIN "values" as v1 on v1.product_id = p.id AND v1.filter_id = 1
LEFT JOIN "values" as v2 on v2.product_id = p.id AND v2.filter_id = 2
WHERE
  (
    v1.value >= 20
    AND
    v1.value <= 40
  )
  AND
  (
    v2.value = 3000
    OR
    v2.value = 4000
  )
;
