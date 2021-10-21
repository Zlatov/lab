DROP TABLE IF EXISTS orders;

CREATE TABLE orders (
  id SERIAL PRIMARY KEY,
  priority INT NOT NULL DEFAULT 0
);
CREATE INDEX ON orders (priority);

INSERT INTO orders (id, priority) VALUES
(DEFAULT, 1),
(DEFAULT, 2),
(DEFAULT, 3),
(DEFAULT, 4),
(DEFAULT, 5),
(DEFAULT, 6),
(DEFAULT, 7);

SELECT
  id,
  priority
FROM orders
ORDER BY priority DESC;

-- WITH cte AS (SELECT *, ROW_NUMBER() OVER() AS rn FROM cards)
-- UPDATE cards SET seq = (SELECT rn FROM cte WHERE cte.pk = cards.pk);

-- UPDATE movimientos m
-- SET    numero = sub.rn
-- FROM  (SELECT id, row_number() OVER (ORDER BY orden, id) AS rn FROM movimientos) sub
-- WHERE  m.id = sub.id;

\set item 1
\set after_item 6
-- \set item 1
-- \set after_item NULL

UPDATE orders o
SET priority = ordered.rn
FROM (
  SELECT *, ROW_NUMBER() OVER() AS rn
  FROM (
    (
      SELECT o.*
      FROM orders o
      LEFT JOIN orders ai ON ai.id = :after_item
      WHERE
        (o.priority < ai.priority OR ai.priority IS NULL) AND
        o.id <> :item
      ORDER BY o.priority ASC
    )
    UNION ALL
    (
      SELECT o.*
      FROM orders o
      WHERE o.id = :item
    )
    UNION ALL
    (
      SELECT o.*
      FROM orders o
      LEFT JOIN orders ai ON ai.id = :after_item
      WHERE
        o.priority >= ai.priority AND
        o.id <> :item
      ORDER BY o.priority ASC
    )
  ) numbered
) ordered
WHERE  o.id = ordered.id;

SELECT
  id,
  priority
FROM orders
ORDER BY priority DESC;
