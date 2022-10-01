\c lab

DROP TABLE IF EXISTS a;

CREATE TABLE a (
  a_id SERIAL PRIMARY KEY,
  slug VARCHAR NULL UNIQUE,
  data jsonb
);

CREATE INDEX uq_a_slug ON a (slug);

-- CREATE INDEX ix_a_dataasd ON a ((data ->> 'asd'));
-- CREATE INDEX ix_a_dataasd ON a (((data ->> 'asd')::int));
CREATE INDEX ix_a_dataasd ON a (((data ->> 'asd')::int)) WHERE (data ->> 'asd') IS NOT NULL;
-- \q

\d+ a
-- \q

INSERT INTO a VALUES
 (DEFAULT,  '1', NULL)
,(DEFAULT,  '2', '{}')
-- ,(DEFAULT,  '2', '')
,(DEFAULT,  '3', '{"asd": 3}')
,(DEFAULT,  '4', '[]')
,(DEFAULT,  '5', '[null]')
,(DEFAULT,  '6', '[null,null]')
,(DEFAULT,  '7', '[null,{}]')
,(DEFAULT,  '8', '[null,{"asd": 4}]')
,(DEFAULT,  '9', '[null,{"asd": 3}]')
,(DEFAULT, '10', '"asd"')
,(DEFAULT, '12', '3')
-- ,(DEFAULT, '121', '{"asd": "asdasd"}')
,(DEFAULT, '122', '{"asd": null}')
,(DEFAULT, '123', '{"asd": "1"}')
,(DEFAULT, '124', '{"asd": 1}')
,(DEFAULT, '125', '{"asd": 1, "zxc": 2}')
,(DEFAULT, '126', '{"asd": 1, "zxc": 2, "qwe": 2}')
,(DEFAULT, '127', '{"zxc": 2}')
,(DEFAULT, '128', '{"list": [13, 12]}')
,(DEFAULT, '13', '""')
,(DEFAULT, '14', '-3.6')
,(DEFAULT, '15', 'null')
,(DEFAULT, '16', '"Кириллический Ёж"')
,(DEFAULT, '17', '"  asd  "')
,(DEFAULT, '18', '"  "')
,(DEFAULT, '19', '"\t"')
,(DEFAULT, '20', '"\n"')
,(DEFAULT, '21', '"\r"')
,(DEFAULT, '22', '"  asd  \n  "')
,(DEFAULT, '23', '
  {
    "asd":     "33",
    "zxc qwe": 1
  }  
')
,(DEFAULT, '24', '{"minmax": -10}')
,(DEFAULT, '25', '{"minmax": 10}')
,(DEFAULT, '26', '{"group": {"id": 1, "value": 1}}')
,(DEFAULT, '27', '{"group": {"id": 1, "value": 2}}')
;
-- \q

select 'Выбираем data' as " ";
SELECT data FROM a;

-- \q

select 'Выбираем data->asd' as " ";
SELECT data->'asd' FROM a;

-- \q

select 'Выбираем data->asd' as " ";
SELECT data->>'asd' FROM a;

-- \q

select 'Выбираем >' as " ";
-- SELECT * FROM a WHERE (data ->> 'asd')::int > 0;
SELECT data->>'asd' FROM a WHERE ((data->>'asd')::int) > '2';

select 'Выбираем 23' as " ";
SELECT * FROM a WHERE (data->>'asd')::int = 33;
-- \q

select 'Выбираем 8' as " ";
SELECT * FROM a WHERE (data#>'{1}') = '{"asd": 4}';
-- \q

select 'Выбираем по JSON' as " ";
-- SELECT * FROM a WHERE (data ->> 'asd')::int > 0;
SELECT * FROM a WHERE data @> '{"asd": 1, "zxc": 2}';

-- \q

select 'Выбираем 128' as " ";
SELECT * FROM a WHERE data->'list' @> '[12]';
-- \q

select 'Выбираем' as " ";
SELECT MIN((data->'minmax')::int) FROM a;
-- \q

select 'Выбираем минимум максимум' as " ";
SELECT
  data->'group'->'id', min((data->'group'->'value')::int), max((data->'group'->'value')::int)
FROM
  a
WHERE
  -- Только из тех строк где нужный jsonb задан.
  data->'group' ? 'id'
GROUP BY
  -- Для использование агрегатторных функций нужна группировка.
  data->'group'->'id';
-- \q

select 'Выбираем data->asd' as " ";
SELECT *, data->>'asd' FROM a WHERE data->>'asd' = '33';

-- jsonb является более строгим, и поэтому запрещает экранирование Unicode для
-- символов, не относящихся к ASCII (те, что выше U+007F), если только кодировка
-- базы данных не UTF8. Он также отклоняет NULLсимвол (\u0000), который не может
-- быть представлен в text типе PostgreSQL.

-- Он не сохраняет пробелы и лишает строки JSON начальных / запаздывающих
-- пробелов, а также пробелы в строке JSON, которые просто повредят ваш код
-- (что, в конце концов, может быть неплохо для вас.)

-- Он не сохраняет порядок ключей объекта , обрабатывая ключи почти так же, как
-- они обрабатываются в словарях Python - несортированные. Вам нужно найти
-- способ обойти это, если вы полагаетесь на порядок ваших ключей JSON.

-- Наконец, jsonbне хранит дубликаты ключей объекта (что, опять же, может быть
-- неплохо , особенно если вы хотите избежать неоднозначности в ваших данных),
-- сохраняя только последнюю запись.
