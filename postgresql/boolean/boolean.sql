SELECT
  '=' AS "Оператор сравнения",
  1 = 2 AS "№1 нет",
  NULL = 1 AS "№2 нет",
  NULL = NULL AS "№3 да",
  2 = 2 AS "№4 да",
  'Бууээээээ' AS "Результат"
UNION ALL
SELECT 
  'IS NOT DISTINCT FROM',
  1 IS NOT DISTINCT FROM 2,
  NULL IS NOT DISTINCT FROM 1,
  NULL IS NOT DISTINCT FROM NULL,
  2 IS NOT DISTINCT FROM 2,
  'Ура'
;
