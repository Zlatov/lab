DROP TABLE IF EXISTS posts;
DROP TABLE IF EXISTS tags;
DROP TABLE IF EXISTS posts_tags;

CREATE TABLE posts (
  id SERIAL PRIMARY KEY
);
CREATE TABLE tags (
  id SERIAL PRIMARY KEY
);
CREATE TABLE posts_tags (
  post_id INT NOT NULL,
  tag_id INT NOT NULL
);
CREATE UNIQUE INDEX ix_posts_tags_postidtagid ON posts_tags (post_id, tag_id);

\i data.sql;
INSERT INTO posts (id) VALUES (DEFAULT), (DEFAULT), (DEFAULT), (DEFAULT);
INSERT INTO tags (id) VALUES (DEFAULT), (DEFAULT);
INSERT INTO posts_tags (post_id, tag_id) VALUES (1, 1), (2, 1), (2, 3), (3, 3);

SELECT '> posts' as " ";
SELECT * FROM posts;
SELECT '> tags' as " ";
SELECT * FROM tags;

SELECT COUNT(*) AS "Постов всего" FROM posts;

SELECT * FROM (VALUES
('> COUNT возвращает количество строк всей таблицы, НО при использовании'),
('> GROUP BY работает как агрегатная функция подсчитывая количество сгруппированных строк'),
('> для каждого уникального значения. Однако возможно использовать COUNT(*) OVER()'),
('> которая возвратит количество строк всего результата выбора, если'),
('> не указывать параметр для OVER().')
) " " (" ");

SELECT
  posts.id "Пост",
  COUNT(*) "Количество тегов у поста",
  COUNT(*) OVER() "Итого постов с тегами"
FROM posts
INNER JOIN posts_tags pt ON pt.post_id = posts.id
GROUP BY posts.id
;

SELECT * FROM (VALUES
('> Функция COUNT(*) OVER(partition BY field) подсчитывает количество повторений значения в выборе'),
('> Удобно при отсутствии GROUP BY, считать сколько раз объект присутствует в связи'),
('> с другим объектом, если это запрос с INNER JOIN.')
) " " (" ");

SELECT
  *,
  COUNT(*) OVER(partition BY posts.id) "Количество тегов у поста",
  COUNT(*) OVER(partition BY pt.tag_id) "Количество постов у тега"
FROM posts
INNER JOIN posts_tags pt ON pt.post_id = posts.id
;
