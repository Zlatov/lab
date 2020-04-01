DROP TABLE IF EXISTS a;
DROP TYPE IF EXISTS a_type;
CREATE TYPE a_type AS ENUM ('one', 'two');

-- Изменение ENUM типа.
-- ALTER TYPE name ADD VALUE new_enum_value [ { BEFORE | AFTER } existing_enum_value ]
ALTER TYPE a_type ADD VALUE 'three' AFTER 'two';

CREATE TABLE a (
  "id" SERIAL PRIMARY KEY,
  "type" a_type NOT NULL DEFAULT 'two'
);
CREATE INDEX ix_a_type ON a ("type");

INSERT INTO a VALUES
  (DEFAULT, 'one'),
  (DEFAULT, DEFAULT)
;

SELECT * FROM a;
