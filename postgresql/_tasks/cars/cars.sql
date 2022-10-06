\c lab;


-- 1 1
--   2
-- 2


DROP TABLE IF EXISTS m;
DROP TABLE IF EXISTS mz;
DROP TABLE IF EXISTS z;


CREATE TABLE m (
  id SERIAL PRIMARY KEY
);
CREATE TABLE mz (
  m_id INTEGER NOT NULL,
  z_id INTEGER NOT NULL 
);
CREATE TABLE z (
  id SERIAL PRIMARY KEY
);

INSERT INTO m (id) VALUES
(DEFAULT),
(DEFAULT);

INSERT INTO z (id) VALUES
(DEFAULT),
(DEFAULT),
(DEFAULT);

INSERT INTO mz (m_id, z_id) VALUES
(1, 1),
(1, 2),
(2, 1),
(2, 2),
(2, 3),
(2, 4)
;

SELECT id FROM m;
SELECT id FROM z;
SELECT m_id, z_id FROM mz;
-- \q

SELECT '> Выбрать вообще все машины с этими деталями' as " ";
SELECT DISTINCT m.id
FROM m
LEFT JOIN mz on mz.m_id = m.id;
-- WHERE mz.z_id IN (1, 2)
-- \q

SELECT '> Выбрать машины которые не нужны' as " ";
SELECT DISTINCT m.id
FROM m
LEFT JOIN mz on mz.m_id = m.id
-- WHERE mz.z_id IN (1, 2)
LEFT JOIN (
  SELECT z.id
  FROM z
  WHERE z.id IN (1, 2)
) asd ON asd.id = mz.z_id
WHERE asd.id IS NULL;
-- \q

SELECT '> Результат' as " ";
SELECT DISTINCT m.id, mnn.id
FROM m
LEFT JOIN mz on mz.m_id = m.id
LEFT JOIN (
  SELECT DISTINCT m.id
  FROM m
  LEFT JOIN mz on mz.m_id = m.id
  LEFT JOIN (
    SELECT z.id
    FROM z
    WHERE z.id IN (1, 2)
  ) asd ON asd.id = mz.z_id
  WHERE asd.id IS NULL
) mnn ON mnn.id = m.id
WHERE mnn.id IS NULL;
\q


-- 1 2
-- 2 null

SELECT DISTINCT m.*
FROM m
LEFT JOIN mz on mz.m_id = m.id
LEFT JOIN z  on z.id = mz.z_id
WHERE z.id IN (1, 2);
-- \q


SELECT m.*, zn.id
-- SELECT *
FROM m
LEFT JOIN mz on mz.m_id = m.id
LEFT JOIN z  on z.id = mz.z_id
LEFT JOIN (
  SELECT z.id
  FROM z
  WHERE z.id IN (1, 2)
) zn ON zn.id = z.id
WHERE zn.id IS NULL;
-- \q


SELECT DISTINCT m.*, mnot.id
FROM m
LEFT JOIN mz on mz.m_id = m.id
LEFT JOIN z  on z.id = mz.z_id
LEFT JOIN (
  SELECT m.id
  -- SELECT m.*, zn.id
  -- SELECT *
  FROM m
  LEFT JOIN mz on mz.m_id = m.id
  LEFT JOIN z  on z.id = mz.z_id
  LEFT JOIN (
    SELECT z.id
    FROM z
    WHERE z.id IN (1, 2)
  ) zn ON zn.id = z.id
  WHERE zn.id IS NULL
) mnot on mnot.id = m.id
WHERE z.id IN (1, 2)
  AND mnot IS NULL
\q


-- SELECT m.*
-- FROM m
-- LEFT JOIN zm on zm.m_id = m.id
-- LEFT JOIN z  on z.id = zm.z_id
-- INNER JOIN (
--   SELECT z.id
--   FROM z
--   WHERE z.id IN (1, 2, 3)
-- ) zn ON zn.id = z.id
