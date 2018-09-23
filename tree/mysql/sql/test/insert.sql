USE lab;
source /home/iadfeshchm/projects/my/lab/tree/mysql/sql/tables.sql;
source /home/iadfeshchm/projects/my/lab/tree/mysql/sql/triggers.sql;
-- source /home/iadfeshchm/projects/my/lab/tree/mysql/sql/procedures.sql;

INSERT INTO tree (pid, header) VALUES (NULL, '1'); SELECT level = 1 as 'test_level' from tree where id = 1;
INSERT INTO tree (pid, header) VALUES (   1, '2'); SELECT level = 2 as 'test_level' from tree where id = 2;
INSERT INTO tree (pid, header) VALUES (   2, '3'); SELECT level = 3 as 'test_level' from tree where id = 3;
INSERT INTO tree (pid, header) VALUES (   3, '4'); SELECT level = 4 as 'test_level' from tree where id = 4;
INSERT INTO tree (pid, header) VALUES (   4, '5'); SELECT level = 5 as 'test_level' from tree where id = 5;
INSERT INTO tree (pid, header) VALUES (   5, '6'); SELECT level = 6 as 'test_level' from tree where id = 6;
INSERT INTO tree (pid, header) VALUES (NULL, '7'); SELECT level = 1 as 'test_level' from tree where id = 7;
INSERT INTO tree (pid, header) VALUES (   7, '8'); SELECT level = 2 as 'test_level' from tree where id = 8;
INSERT INTO tree (pid, header) VALUES (   7, '9'); SELECT level = 2 as 'test_level' from tree where id = 9;
