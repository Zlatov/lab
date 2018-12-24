DROP TABLE IF EXISTS tree_rel;
DROP TABLE IF EXISTS tree;

DROP SEQUENCE IF EXISTS tree_id_seq;
CREATE SEQUENCE tree_id_seq;

CREATE TABLE IF NOT EXISTS tree (
  id integer DEFAULT nextval('tree_id_seq') PRIMARY KEY,
  pid integer REFERENCES tree (id) ON DELETE CASCADE ON UPDATE CASCADE,

  "order" integer DEFAULT 0,
  name varchar(180)
);
COMMENT ON TABLE tree IS 'Элементы древовидной структуры.';
COMMENT ON COLUMN tree.pid IS 'Идентификатор предка по Adjacency List.';
COMMENT ON COLUMN tree.order IS 'Сортировочное значение.';

CREATE INDEX ix_tree_pid ON tree (pid);
COMMENT ON INDEX ix_tree_pid IS 'Индекс для поиска по идентификатору предка.';

CREATE INDEX CONCURRENTLY ix_tree_order ON tree ("order");
COMMENT ON INDEX ix_tree_order IS 'Индекс для сортировки по значению.';


CREATE TABLE IF NOT EXISTS tree_rel (
  aid integer NOT NULL REFERENCES tree (id) ON DELETE CASCADE ON UPDATE CASCADE,
  did integer NOT NULL REFERENCES tree (id) ON DELETE CASCADE ON UPDATE CASCADE,
  -- gen integer NOT NULL,
  UNIQUE (aid, did)
);
COMMENT ON TABLE tree_rel IS 'Таблица связей древовидной структуры по шаблону Closure Table.';
COMMENT ON COLUMN tree_rel.aid IS '(ancestor id) идентификатор предка.';
COMMENT ON COLUMN tree_rel.did IS '(descendant id) идентификатор потомка.';
-- COMMENT ON COLUMN tree_rel.gen IS 'В каком поколении родственнички друг к другу.';

CREATE INDEX ix_treerel_aid ON tree_rel (aid);
CREATE INDEX ix_treerel_did ON tree_rel (did);
-- CREATE UNIQUE INDEX ix_treerel_aiddid ON tree_rel (aid, did)
