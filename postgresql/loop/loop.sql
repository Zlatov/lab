-- LOOP
--     -- здесь производятся вычисления
--     EXIT WHEN count > 100;
--     CONTINUE WHEN count < 50;
--     -- вычисления для count в диапазоне 50 .. 100
-- END LOOP;

FOR i IN 1..10 LOOP
  SELECT i;
END LOOP;
