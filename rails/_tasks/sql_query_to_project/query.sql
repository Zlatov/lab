\c mini_light_development

SELECT id, code, property_values FROM products;
-- \q

-- SELECT property_values::jsonb FROM products;
SELECT property_values::jsonb->'2' FROM products;
-- \q


SELECT 'Выбираем продукты со значениме 2 фильтра 1' AS " ";
SELECT id, code, property_values FROM products
WHERE
  products.property_values->'1' @> '["2"]'
;
-- \q

SELECT 'Выбираем продукты с фильтром 2' AS " ";
SELECT id, code, property_values
FROM products p
WHERE
  p.property_values ? '2'
;
-- \q

SELECT 'Выбираем продукты со значением >= 16 фильтра 2' AS " ";
SELECT id, code, property_values
FROM products p
WHERE
  (p.property_values->'2')::INT >= 16
;
-- \q

SELECT 'Выбираем продукты с каким либо из значений массива ["1", "2"] фильтра 1 (не пустое пересечение)' AS " ";
SELECT id, code, property_values
FROM products p
WHERE
  p.property_values->'1' ?| ARRAY['1', '2']
;
-- \q

SELECT 'Выбираем продукты с каким либо из значений массива ["15"] фильтра 2 в котором число (не пустое пересечение)' AS " ";
SELECT id, code, property_values
FROM products p
WHERE
  to_jsonb(p.property_values->>'2') ?| ARRAY['15']
;
-- \q

SELECT 'Выбираем значения фильтров из продутов с фильтром 2' AS " ";
SELECT *
FROM
  -- products p
  -- LEFT JOIN jsonb_each(p.attrs) a ON true
  -- CROSS JOIN jsonb_each(p.attrs) a
  products p,
  jsonb_each(p.property_values) a
WHERE p.property_values ? '2'
;
-- \q

SELECT 'Все продукты' AS " ";
SELECT id, code, property_values FROM products;

SELECT 'Выбираем значения фильтров из продуктов с фильтром 2 или 3' AS " ";
SELECT a.key::INT, json_agg(a.value) AS "values"
FROM
  products p,
  jsonb_each(p.property_values) a
WHERE
  p.property_values ? '2' OR
  p.property_values ? '3'
GROUP BY
  a.key
HAVING
  a.key IN ('2', '3')
;
-- \q
SELECT f.*, v.values
FROM
  properties f
  LEFT JOIN (
    SELECT a.key::INT, json_agg(a.value) AS "values"
    FROM
      products p,
      jsonb_each(p.property_values) a
    WHERE
      p.property_values ? '2' OR
      p.property_values ? '3'
    GROUP BY
      a.key
    HAVING
      a.key IN ('2', '3')
  ) v ON v.key = f.id
WHERE
 f.filter = TRUE
;
-- \q

-- Выгрибаем все ключи фильтров в продуктах
SELECT DISTINCT jsonb_object_keys(property_values) FROM products;
-- Выбираем назначенные свойства
SELECT to_jsonb(property_values) FROM products;
-- \q

SELECT '> Задача: Выбрать товары у которых назначено какое-либо значение из фильтра с номером' AS " ";
SELECT id, code, property_values
FROM products p
WHERE
  p.property_values ? '204'
;
