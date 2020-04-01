SELECT
  a.*,
  ROW_NUMBER() OVER() AS "rn"
FROM (
  VALUES
    (0, 'строка0'),
    (1, 'строка1'),
    (2, 'строка2')
) a (c1, c2)
ORDER BY a.c1 DESC -- Сортировка так же инвертирует нумерацию строк
;
