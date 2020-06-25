\c postgres;
DROP DATABASE IF EXISTS lab;
CREATE DATABASE lab;
\c lab;

CREATE TABLE categories (
  id SERIAL PRIMARY KEY,
  pid INTEGER NULL,
  name VARCHAR NOT NULL UNIQUE,
  slug VARCHAR NOT NULL UNIQUE
);
ALTER TABLE categories ADD CONSTRAINT fk_categories_pid
FOREIGN KEY (pid) REFERENCES categories(id) ON UPDATE CASCADE ON DELETE RESTRICT;
CREATE INDEX ix_categories_pid ON categories (pid);

CREATE TABLE products (
  id SERIAL PRIMARY KEY,
  name VARCHAR NOT NULL UNIQUE,
  code CHAR(9) NOT NULL UNIQUE
);

CREATE TABLE categories_products (
  category_id INTEGER NOT NULL,
  product_id INTEGER NOT NULL
);
CREATE INDEX ix_categories_products_categoryid ON categories_products (category_id);
CREATE INDEX ix_categories_products_productid ON categories_products (product_id);
CREATE UNIQUE INDEX uq_categories_products_catprodid ON categories_products (category_id, product_id);
ALTER TABLE categories_products ADD CONSTRAINT fk_categories_products_categoryid
FOREIGN KEY (category_id) REFERENCES categories(id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE categories_products ADD CONSTRAINT fk_categories_products_productid
FOREIGN KEY (product_id) REFERENCES products(id) ON UPDATE CASCADE ON DELETE CASCADE;

SELECT '> Индексы в текущей базе данных' as " ";
SELECT
  tablename,
  indexname,
  indexdef
FROM
  pg_indexes
WHERE
  schemaname = 'public'
ORDER BY
  tablename,
  indexname;

INSERT INTO categories (id, pid, name, slug) VALUES
(DEFAULT, NULL, 'Catecory 1', 'catecory1'),
(DEFAULT, 1,    'Catecory 2', 'catecory2'),
(DEFAULT, 1,    'Catecory 3', 'catecory3'),
(DEFAULT, 1,    'Catecory 4', 'catecory4'),
(DEFAULT, 1,    'Catecory 5', 'catecory5');

INSERT INTO products (id, name, code) VALUES
(DEFAULT, 'Product 1', '000000001'),
(DEFAULT, 'Product 2', '000000002'),
(DEFAULT, 'Product 3', '000000003'),
(DEFAULT, 'Product 4', '000000004'),
(DEFAULT, 'Product 5', '000000005'),
(DEFAULT, 'Product 6', '000000006'),
(DEFAULT, 'Product 7', '000000007'),
(DEFAULT, 'Product 8', '000000008'),
(DEFAULT, 'Product 9', '000000009');

INSERT INTO categories_products (category_id, product_id) VALUES
(3, 1),
(4, 2),
(4, 3),
(5, 4),
(5, 5),
(5, 6);

SELECT *
FROM categories;

SELECT *
FROM products;

SELECT *
FROM categories_products;

SELECT '> Выбрать по два продукта из каждой категории являющейся потомком категории 1.' as " ";

SELECT *
FROM categories c
INNER JOIN categories_products cp ON cp.category_id = c.id
WHERE c.pid = 1;

SELECT *
FROM categories c
INNER JOIN categories_products cp ON cp.category_id = c.id AND cp.product_id IN (
  SELECT cp2.product_id
  FROM categories_products cp2
  WHERE cp2.category_id = c.id
  LIMIT 2
)
WHERE c.pid = 1
;
