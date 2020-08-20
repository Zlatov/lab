\q

CREATE INDEX ON table_name (field_name);
CREATE INDEX ix_table_name_fieldname ON table_name (field_name);
CREATE INDEX ix_table_name_fieldnamefieldname2 ON table_name (field_name, field_name2);
CREATE UNIQUE INDEX uq_table_name_fieldname ON table_name (field_name);

CREATE INDEX ix_table_name_fieldname ON table_name (field_name ASC NULLS FIRST); -- значения NULL после сортировки оказываются перед остальными
CREATE INDEX ix_table_name_fieldname ON table_name (field_name NULLS LAST);
