USE lab;
SET @successes_count = 0; -- Количество пройденных тестов.

-- Тест на правильное выставление level при вставке.
source /home/iadfeshchm/projects/my/lab/tree/mysql/sql/tables.sql;
source /home/iadfeshchm/projects/my/lab/tree/mysql/sql/triggers.sql;
-- source /home/iadfeshchm/projects/my/lab/tree/mysql/sql/procedures.sql;
INSERT INTO tree (pid) VALUES (NULL);
SELECT @successes_count := @successes_count + CAST(level = 1 AS SIGNED INT) FROM tree WHERE id = 1;
INSERT INTO tree (pid) VALUES (1);
SELECT @successes_count := @successes_count + CAST(level = 2 AS SIGNED INT) FROM tree WHERE id = 2;
INSERT INTO tree (pid) VALUES (2);
SELECT @successes_count := @successes_count + CAST(level = 3 AS SIGNED INT) FROM tree WHERE id = 3;
INSERT INTO tree (pid) VALUES (3);
SELECT @successes_count := @successes_count + CAST(level = 4 AS SIGNED INT) FROM tree WHERE id = 4;
INSERT INTO tree (pid) VALUES (4);
SELECT @successes_count := @successes_count + CAST(level = 5 AS SIGNED INT) FROM tree WHERE id = 5;
INSERT INTO tree (pid) VALUES (5);
SELECT @successes_count := @successes_count + CAST(level = 6 AS SIGNED INT) FROM tree WHERE id = 6;
INSERT INTO tree (pid) VALUES (NULL);
SELECT @successes_count := @successes_count + CAST(level = 1 AS SIGNED INT) FROM tree WHERE id = 7;
INSERT INTO tree (pid) VALUES (7);
SELECT @successes_count := @successes_count + CAST(level = 2 AS SIGNED INT) FROM tree WHERE id = 8;
INSERT INTO tree (pid) VALUES (7);
SELECT @successes_count := @successes_count + CAST(level = 2 AS SIGNED INT) FROM tree WHERE id = 9;

-- Тест на правильное количество связей при вставке.
source /home/iadfeshchm/projects/my/lab/tree/mysql/sql/tables.sql;
source /home/iadfeshchm/projects/my/lab/tree/mysql/sql/triggers.sql;
-- source /home/iadfeshchm/projects/my/lab/tree/mysql/sql/procedures.sql;
INSERT INTO tree (pid) VALUES (NULL);
SELECT @successes_count := @successes_count + CAST(COUNT(aid) = 0 AS SIGNED INT) FROM tree_rel;
INSERT INTO tree (pid) VALUES (NULL);
SELECT @successes_count := @successes_count + CAST(COUNT(aid) = 0 AS SIGNED INT) FROM tree_rel;
INSERT INTO tree (pid) VALUES (1);
SELECT @successes_count := @successes_count + CAST(COUNT(aid) = 1 AS SIGNED INT) FROM tree_rel;

SELECT
  IF(@successes_count = 12, 'Тест пройден.', 'Тест не пройден.') as 'Результат',
  @successes_count as 'Пройдено',
  12 as 'Необходимо';
