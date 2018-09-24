DROP TABLE IF EXISTS a;
CREATE TABLE IF NOT EXISTS a (id INT UNSIGNED NOT NULL AUTO_INCREMENT, PRIMARY KEY (id));

-- Так:
SET @count = 1;
SELECT @count;

-- В селекте:
SELECT @count := COUNT(*) FROM a;
SELECT @count;
SELECT @count := 1 + COUNT(*) FROM a;
SELECT @count;
SELECT @count := 1 + @count;
SELECT @count;
-- exit

-- В процедурах
DROP PROCEDURE IF EXISTS a;
DELIMITER ;;
CREATE PROCEDURE a(IN param_value INT)
BEGIN
  DECLARE i INT;
  DECLARE n INT DEFAULT 0;
  -- Так:
  SET i = 100;

  -- В селекте:
  SELECT COUNT(*) INTO n
  FROM a;

  SELECT i, n;
END;;
DELIMITER ;

CALL a(2);
