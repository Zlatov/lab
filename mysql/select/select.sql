DROP table if exists test;
create table test (numbers INT, texts varchar(255));
insert into test values (1,NULL),(2,NULL),(3,NULL),(4,NULL),(5,NULL),(6,NULL),(7,NULL),(8,NULL),(9,NULL),(NULL,'text');

SELECT 1; -- 1
SELECT 1 as `number`; -- 1
SELECT * FROM `test`; -- Всё из таблицы
SELECT * FROM `test` LIMIT 1; -- Первую попавшуюся
SELECT * FROM `test` LIMIT 0, 2; -- Две записи, начиная с первой (отсчет от нуля, ага)
SELECT SQL_CALC_FOUND_ROWS * FROM `test` LIMIT 0, 2; -- Ограниченное количество записей с запонинанием сколько записей всего
SELECT FOUND_ROWS();
SELECT SQL_CALC_FOUND_ROWS * from test where numbers > 3 limit 2; -- SQL_CALC_FOUND_ROWS работает только на лимит.
SELECT FOUND_ROWS();

DROP table if exists test;
create table test (asd INT, zxc INT, qwe INT);
insert into test values
(1,2,2),
(1,2,3),
(1,2,4)
;

select *
from test
where asd + zxc + qwe > 6;


/*
SELECT
    [ALL | DISTINCT | DISTINCTROW ]
      [HIGH_PRIORITY]
      [STRAIGHT_JOIN]
      [SQL_SMALL_RESULT] [SQL_BIG_RESULT] [SQL_BUFFER_RESULT]
      [SQL_CACHE | SQL_NO_CACHE] [SQL_CALC_FOUND_ROWS]
    select_expr [, select_expr ...]
    [FROM table_references
      [PARTITION partition_list]
    [WHERE where_condition]
    [GROUP BY {col_name | expr | position}
      [ASC | DESC], ... [WITH ROLLUP]]
    [HAVING where_condition]
    [ORDER BY {col_name | expr | position}
      [ASC | DESC], ...]
    [LIMIT {[offset,] row_count | row_count OFFSET offset}]
    [PROCEDURE procedure_name(argument_list)]
    [INTO OUTFILE 'file_name'
        [CHARACTER SET charset_name]
        export_options
      | INTO DUMPFILE 'file_name'
      | INTO var_name [, var_name]]
    [FOR UPDATE | LOCK IN SHARE MODE]]
*/
