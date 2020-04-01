DROP TABLE IF EXISTS "values";
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS filters;

-- Продукты
CREATE TABLE products (
  "id" SERIAL PRIMARY KEY,
  "name" TEXT NOT NULL UNIQUE,
  "values" JSONB NOT NULL DEFAULT '{}'
);

-- Фильтры
CREATE TABLE filters (
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL UNIQUE,
  slug TEXT NOT NULL UNIQUE
);

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

UPDATE products SET "values" = "values" || '{"dlina_sm": 10}' WHERE id = 1;
UPDATE products SET "values" = "values" || '{"dlina_sm": 20}' WHERE id = 2;
UPDATE products SET "values" = "values" || '{"dlina_sm": 30}' WHERE id = 3;
UPDATE products SET "values" = "values" || '{"dlina_sm": 40}' WHERE id = 4;
UPDATE products SET "values" = "values" || '{"dlina_sm": 50}' WHERE id = 5;

-- UPDATE products SET "values" = "values" || '{"chastota": 1000}' WHERE id = 1;
-- UPDATE products SET "values" = "values" || '{"chastota": 2000}' WHERE id = 2;
-- UPDATE products SET "values" = "values" || '{"chastota": 3000}' WHERE id = 3;
-- UPDATE products SET "values" = "values" || '{"chastota": 4000}' WHERE id = 4;
UPDATE products SET "values" = "values" || '{"chastota": "1000"}' WHERE id = 1;
UPDATE products SET "values" = "values" || '{"chastota": "2000"}' WHERE id = 2;
UPDATE products SET "values" = "values" || '{"chastota": "3000"}' WHERE id = 3;
UPDATE products SET "values" = "values" || '{"chastota": "4000"}' WHERE id = 4;

UPDATE products SET "values" = "values" || '{"cvet": "красный"}' WHERE id = 1;
UPDATE products SET "values" = "values" || '{"cvet": "зелёный"}' WHERE id = 2;
UPDATE products SET "values" = "values" || '{"cvet": "синий"}' WHERE id = 3;


-- Выбор всего
SELECT '> products' as " ";
SELECT * FROM products;
SELECT '> filters' as " ";
SELECT * FROM filters;
-- \q


-- Выбор отфильтрованный
SELECT '> Выбор отфильтрованный' as " ";
SELECT
  p.*
FROM products as p
WHERE
  (
    (p.values->>'dlina_sm')::NUMERIC >= 20
    AND
    (p.values->>'dlina_sm')::NUMERIC <= 40
  )
  -- AND
  -- (
  --   (p.values->>'chastota')::NUMERIC = 3000
  --   OR
  --   (p.values->>'chastota')::NUMERIC = 4000
  -- )
  AND
  (
    p.values->>'chastota' = '3000'
    OR
    p.values->>'chastota' = '4000'
  )
  AND
  (
    p.values->>'cvet' = 'синий'
  )
;
