.exit

CASE case_expression
  WHEN when_expression_1 THEN result_1
  WHEN when_expression_2 THEN result_2
  ...
  [ ELSE result_else ]
END

-- или

CASE
  WHEN bool_expression_1 THEN result_1
  WHEN bool_expression_2 THEN result_2
  [ ELSE result_else ]
END

-- пример

SELECT customerid,
       firstname,
       lastname,
       CASE country 
           WHEN 'USA' 
               THEN 'Dosmetic' 
           ELSE 'Foreign' 
       END CustomerGroup
FROM 
    customers
ORDER BY 
    LastName,
    FirstName;

-- или

SELECT
    trackid,
    name,
    CASE
        WHEN milliseconds < 60000 THEN
            'short'
        WHEN milliseconds > 60000 AND milliseconds < 300000 THEN 'medium'
        ELSE
            'long'
        END category
FROM
    tracks;
