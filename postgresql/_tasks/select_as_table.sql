select *, ROW_NUMBER() OVER() AS "rn"
from (
  VALUES (1, 1),
    (2, 2)
) a (c1, c2);
