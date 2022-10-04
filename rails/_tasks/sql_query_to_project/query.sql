\c mini_light_development

SELECT id, code, property_values FROM products;
-- \q

-- SELECT property_values::jsonb FROM products;
SELECT property_values::jsonb->'2' FROM products;
-- \q


select 'Выбираем продукты со значениме 2 фильтра 1' as " ";
SELECT id, code, property_values FROM products
WHERE
  products.property_values->'1' @> '["2"]'
;
-- \q

select 'Выбираем продукты с фильтром 2' as " ";
SELECT id, code, property_values
FROM products p
WHERE
  p.property_values ? '2'
;
-- \q

select 'Выбираем продукты со значением >= 16 фильтра 2' as " ";
SELECT id, code, property_values
FROM products p
WHERE
  (p.property_values->'2')::int >= 16
;
-- \q

select 'Выбираем продукты с каким либо из значений массива ["1", "2"] фильтра 1 (не пустое пересечение)' as " ";
SELECT id, code, property_values
FROM products p
WHERE
  p.property_values->'1' ?| ARRAY['1', '2']
;
-- \q

select 'Выбираем продукты с каким либо из значений массива ["15"] фильтра 2 в котором число (не пустое пересечение)' as " ";
SELECT id, code, property_values
FROM products p
WHERE
  to_jsonb(p.property_values->>'2') ?| ARRAY['15']
;
-- \q

select 'Выбираем значения фильтров из продутов с фильтром 2' as " ";
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

select 'Все продукты' as " ";
SELECT id, code, property_values FROM products;

select 'Выбираем значения фильтров из продуктов с фильтром 2 или 3' as " ";
SELECT a.key::int, json_agg(a.value) as "values"
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
    SELECT a.key::int, json_agg(a.value) as "values"
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
  ) v on v.key = f.id
WHERE
 f.filter = true
;
-- \q

-- Выгрибаем все ключи фильтров в продуктах
SELECT DISTINCT jsonb_object_keys(property_values) FROM products;
-- Выбираем назначенные свойства
SELECT to_jsonb(property_values) from products;
-- \q
