-- IF(expr1,expr2,expr3)
SELECT IF(1 > 0, '1 больше 0', 0) as '1 > 0 ?';
-- IFNULL(expr1,expr2). Если expr1 не равно NULL, то expr1, иначе expr2.
SELECT IFNULL(NULL, 'null !') as 'null ?';
