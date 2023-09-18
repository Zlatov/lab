\c lab

DROP TABLE IF EXISTS products;

CREATE TABLE products (
  id SERIAL PRIMARY KEY,
  data jsonb
);

INSERT INTO products VALUES
 (DEFAULT, NULL)
,(DEFAULT, '{}')
,(DEFAULT, '{"1": null}')
,(DEFAULT, '{"1": 11}')
,(DEFAULT, '{"1": "11"}')
,(DEFAULT, '{"2": null}')
,(DEFAULT, '{"2": 22}')
,(DEFAULT, '{"2": "22"}')
,(DEFAULT, '{"1": "11", "2": "22", "3": "333"}')
;
-- \q

SELECT * FROM products;
-- \q

SELECT 'Выберем все записи у которых есть ключ data.1' as " ";
SELECT * FROM products WHERE data ? '1';
-- \q

SELECT 'Выберем json с удалением ключа 1 у всех записей с ключом data.1' as " ";
SELECT id, data - '1' as "update" FROM products WHERE data ? '1';
-- \q

SELECT 'Обновим записи - удалим ключ data.1 у записей с ключом data.1' as " ";
UPDATE products SET data = data - '1' WHERE data ? '1';
UPDATE products SET data = data #- '{1}' WHERE data ? '1';

SELECT * FROM products;
