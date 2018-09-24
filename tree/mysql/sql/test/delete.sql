USE lab;
SET @successes_count = 0; -- Количество пройденных тестов.

-- Тест на количество связей после удаления.
source /home/iadfeshchm/projects/my/lab/tree/mysql/sql/tables.sql;
source /home/iadfeshchm/projects/my/lab/tree/mysql/sql/triggers.sql;
-- source /home/iadfeshchm/projects/my/lab/tree/mysql/sql/procedures.sql;
INSERT INTO tree (pid) VALUES (NULL), (1), (2), (3), (4), (5);
DELETE FROM tree WHERE id = 4;
SELECT @successes_count := @successes_count + CAST(COUNT(*) = 3 AS SIGNED INT) FROM tree_rel;

SELECT
  IF(@successes_count = 1, 'Тест пройден.', 'Тест не пройден.') as 'Результат',
  @successes_count as 'Пройдено',
  1 as 'Необходимо';
