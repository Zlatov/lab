DROP TABLE IF EXISTS posts;

CREATE TABLE posts (
  id SERIAL PRIMARY KEY,
  priority VARCHAR NOT NULL DEFAULT 'LOW'
);

INSERT INTO posts (id, priority) VALUES
(DEFAULT, DEFAULT),
(DEFAULT, 'MEDIUM'),
(DEFAULT, 'HIGH');

SELECT *
FROM posts
ORDER BY
  priority ASC,
  id ASC
;
-- \q

SELECT *
FROM posts
ORDER BY
  CASE priority 
  WHEN 'HIGH' THEN 'a' 
  WHEN 'MEDIUM' THEN 'b' 
  WHEN 'LOW' THEN 'c' 
  ELSE 'z' 
  END ASC, 
  id ASC
;
