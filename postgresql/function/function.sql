DROP TABLE IF EXISTS a;

CREATE TABLE a (
  id SERIAL PRIMARY KEY,
  name varchar
);

CREATE OR REPLACE FUNCTION af(vcount integer) RETURNS VOID AS
$$
BEGIN
  FOR i IN 1..vcount LOOP
    INSERT INTO a ("name") VALUES
    ('asd');
  END LOOP;
END
$$ LANGUAGE plpgsql;

SELECT af(3);

SELECT COUNT("id") AS "count" FROM "a";

DROP FUNCTION IF EXISTS af(integer);
