-- IS NOT DISTINCT FROM (INDF) - Сравнение значений, в отличии от "=" INDF
-- работает если в сравнении присутствует NULL.

-- Оператор "=" и заголовки столбцов
SELECT
  '=' AS "Оператор сравнения",
  1 = 2 AS "№1 д.б нет",
  NULL = 1 AS "№2 д.б нет",
  NULL = NULL AS "№3 д.б да, равны",
  NULL != NULL AS "№3.1 д.б нет, не равны",
  2 = 2 AS "№4 да",
  'Бууээээээ' AS "Результат"
UNION ALL
-- Оператор INDF
SELECT
  'IS NOT DISTINCT FROM',
  1 IS NOT DISTINCT FROM 2,
  NULL IS NOT DISTINCT FROM 1,
  NULL IS NOT DISTINCT FROM NULL,
  NULL IS DISTINCT FROM NULL,
  2 IS NOT DISTINCT FROM 2,
  'Ура'
-- Оператор <>
UNION ALL
SELECT
  '<>',
  1 <> 2,
  NULL <> 1,
  NULL <> NULL,
  NOT(NULL <> NULL),
  2 <> 2,
  'Бууээээээ'
;
