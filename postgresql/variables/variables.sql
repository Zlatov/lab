-- Способ раз
\set myvar 5
SELECT :myvar + 1 AS my_var_plus_1;


-- Способ 2
-- begin;
SELECT
  5::int AS var1,
  'asd'::varchar AS var2
INTO TEMP TABLE vars;
SELECT * FROM vars;
-- commit;


-- Способ 3
WITH vars2 (var1, var2) as (
  values (5, 'foo')
)
SELECT var2, var1 FROM vars2;
