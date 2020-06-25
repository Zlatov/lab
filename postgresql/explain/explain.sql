\c postgres;
DROP DATABASE IF EXISTS lab;
CREATE DATABASE lab;
\c lab;

CREATE TABLE foo (c1 integer, c2 text);
INSERT INTO foo
  SELECT i, md5(random()::text)
  FROM generate_series(1, 100000) AS i;

EXPLAIN SELECT * FROM foo;

-- Seq Scan — последовательное чтение данных.
-- cost — не время, а некое понятие, призванное оценить затратность операции.
-- Первое значение 0.00 — затраты на получение первой строки.
-- Второе значение 18334.00 — затраты на получение всех строк.
-- rows — приблизительное количество возвращаемых строк при выполнении операции Seq Scan.
-- width — средний размер одной строки в байтах.

INSERT INTO foo
  SELECT i, md5(random()::text)
  FROM generate_series(1, 10) AS i;

EXPLAIN SELECT * FROM foo;

-- Значение rows не изменилось. Статистика по таблице старая. Для обновления
-- статистики вызываем команду ANALYZE.

ANALYZE foo;
EXPLAIN SELECT * FROM foo;

-- Теперь реальные данные а не планировщик:

EXPLAIN (ANALYZE) SELECT * FROM foo;

-- Такой запрос будет исполняется реально. Так что если EXPLAIN (ANALYZE) для
-- INSERT, DELETE или UPDATE, ваши данные изменятся!

-- В выводе команды информации добавилось:
-- actual time — реальное время в миллисекундах, затраченное для получения
-- первой строки и всех строк соответственно.
-- rows — реальное количество строк, полученных при Seq Scan.
-- loops — сколько раз пришлось выполнить операцию Seq Scan.
-- Total runtime — общее время выполнения запроса.


-- Теперь на счёт кэша

EXPLAIN (ANALYZE,BUFFERS) SELECT * FROM foo;

-- Buffers: shared hit — количество блоков, считанных из кэша PostgreSQL. Если
-- повторите этот запрос несколько раз, то увидите, как PostgreSQL с каждым
-- разом всё больше данных берёт из кэша. С каждым запросом PostgreSQL наполняет
-- свой кэш. Операции чтения из кэша быстрее, чем операции чтения с диска.
-- Можете заметить эту тенденцию, отслеживая значение Total runtime. Объём кэша
-- определяется константой shared_buffers в файле postgresql.conf.

-- Теперь индекс

-- Index Scan вместо Seq Scan,
-- Index Cond вместо Filter.

-- Индекс по строковым данным

CREATE INDEX ON foo(c2);
EXPLAIN (ANALYZE) SELECT * FROM foo
WHERE c2 LIKE 'abcd%';

-- Опять Seq Scan? Индекс не используется потому, что база у меня для текстовых
-- полей использует формат UTF-8. При создании индекса в таких случаях надо
-- использовать класс оператора text_pattern_ops:

CREATE INDEX ON foo(c2 text_pattern_ops);
EXPLAIN SELECT * FROM foo WHERE c2 LIKE 'abcd%';


-- Итого

-- Seq Scan — читается вся таблица.
-- Index Scan — используется индекс для условий WHERE, читает таблицу при отборе
-- строк.
-- Bitmap Index Scan — сначала Index Scan, затем контроль выборки по таблице.
-- Эффективно для большого количества строк.
-- Index Only Scan — самый быстрый. Читается только индекс.
