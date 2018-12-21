DROP TRIGGER IF EXISTS tbi_tree ON tree;
DROP FUNCTION IF EXISTS fbi_tree();

DROP TRIGGER IF EXISTS tai_tree ON tree;
DROP FUNCTION IF EXISTS fai_tree();

DROP TRIGGER IF EXISTS tbu_tree ON tree;
DROP FUNCTION IF EXISTS fbu_tree();


CREATE OR REPLACE FUNCTION fbi_tree()
RETURNS trigger AS $$
BEGIN
  IF NEW.name IS NULL OR NEW.name = '' THEN
    NEW.name := NEW.id;
  END IF;
  RETURN NEW;
END;
$$
LANGUAGE plpgsql;

CREATE TRIGGER tbi_tree BEFORE INSERT ON tree FOR EACH ROW EXECUTE PROCEDURE fbi_tree();

-- После вставки в структуру добавляем связи.
CREATE OR REPLACE FUNCTION fai_tree()
RETURNS trigger AS $$
BEGIN
  -- Если вставляем элемент в корень, то связи не добавляем.
  IF NEW.pid IS NOT NULL THEN
    -- Вставляем связи.
    INSERT INTO tree_rel (aid, did)
    -- Выбираем предков указанного родителя (did = idРодителя)
    -- и вставляем записи типа: idПредка, нашId.
    SELECT aid, NEW.id
    FROM tree_rel
    WHERE did = NEW.pid
    -- Родитель тоже предок
    UNION ALL
    SELECT NEW.pid, NEW.id;
  END IF;
  RETURN NEW;
END;
$$
LANGUAGE plpgsql;

CREATE TRIGGER tai_tree AFTER INSERT ON tree FOR EACH ROW EXECUTE PROCEDURE fai_tree();

-- После вставки в структуру добавляем связи.
CREATE OR REPLACE FUNCTION fbu_tree()
RETURNS trigger AS $$
DECLARE
  count_descendant int DEFAULT 0;
  delta_level int DEFAULT 0;
BEGIN
  -- Если родитель изменился.
  IF OLD.pid IS DISTINCT FROM NEW.pid THEN
    -- Нельзя перемещать в своих потомков
    SELECT count(*) INTO count_descendant
    FROM tree_rel r
    WHERE
      r.aid = OLD.id
      AND r.did = NEW.pid;
    IF count_descendant > 0 THEN
      RAISE EXCEPTION 'Не верный NEW.pid.' USING HINT = 'Нельзя перемещать элеиент в своих потомков.';
    END IF;

    -- -- Удалить связи потомков перемещаемого элемента и элемента с предками перемещаемого элемента
    -- --               (aid = OLD.id                 )   (OLD.id)   (did = OLD.id)
    -- DELETE relations
    -- FROM tree_rel descendants -- потомки (descendants.aid = OLD.id)
    -- LEFT JOIN tree_rel relations ON relations.did = -- предки потомков ()
    -- INNER JOIN tree_rel
    -- WHERE descendants.aid = OLD.id
  END IF;
  RETURN NEW;
END;
$$
LANGUAGE plpgsql;

CREATE TRIGGER tbu_tree BEFORE UPDATE ON tree FOR EACH ROW EXECUTE PROCEDURE fbu_tree();
