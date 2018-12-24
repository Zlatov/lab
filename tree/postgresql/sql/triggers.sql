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
  -- Если вставляем элемент в корень, то добавляем связь только на себя.
  IF NEW.pid IS NULL THEN
    INSERT INTO tree_rel (aid, did)
    VALUES (NEW.id, NEW.id);
  ELSE
    INSERT INTO tree_rel (aid, did)
    -- Выбираем предков указанного родителя (did = idРодителя)
    -- и вставляем записи типа: idПредка, нашId.
    SELECT aid, NEW.id
    FROM tree_rel
    WHERE did = NEW.pid
    UNION ALL SELECT NEW.id, NEW.id;
  END IF;
  RETURN NEW;
END;
$$
LANGUAGE plpgsql;

CREATE TRIGGER tai_tree AFTER INSERT ON tree FOR EACH ROW EXECUTE PROCEDURE fai_tree();

-- Пред обновлением проверяем на перемещение.
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

    -- Удалить связи потомков перемещаемого элемента и элемента с предками перемещаемого элемента
    DELETE
    FROM tree_rel tr
    USING (
      SELECT *
      FROM (
        -- Ид-ры чистых предков перемещаемого элемента
        SELECT aid
        FROM tree_rel
        WHERE did = OLD.id AND aid != OLD.id
      ) AS a
      CROSS JOIN (
        -- Ид-ры потомков перемещаемого элемента и самого элемента 
        SELECT did
        FROM tree_rel
        WHERE aid = OLD.id
      ) AS b
    ) AS rel
    WHERE tr.aid = rel.aid AND tr.did = rel.did;

    -- Если переместили не в корень то создаём связи с новыми предками
    IF NEW.pid IS NOT NULL THEN

      INSERT INTO tree_rel
      SELECT a.aid, b.did
      FROM (
        SELECT r1.aid
        FROM tree_rel r1
        WHERE r1.did = NEW.pid AND r1.aid <> OLD.id
      ) AS a
      CROSS JOIN (
        SELECT r1.did
        FROM tree_rel r1
        WHERE r1.aid = OLD.id
      ) AS b;

      -- Обновляем уровень перемещаемого элемента
      -- Определяем смещение по уровню
      -- SELECT CAST(`newparent`.`level` + 1 AS SIGNED) - CAST(`moveditem`.`level` AS SIGNED) INTO delta_level
      -- FROM `categories` `newparent`
      -- LEFT JOIN `categories` `moveditem` ON `moveditem`.`id` = OLD.`id`
      -- WHERE `newparent`.`id` = NEW.`pid`;

      -- IF delta_level <> 0 THEN
      --   SET NEW.`level` = OLD.`level` + delta_level;
      -- END IF;
    ELSE
      -- SET NEW.`level` = 1;
    END IF;
  END IF;
  RETURN NEW;
END;
$$
LANGUAGE plpgsql;

CREATE TRIGGER tbu_tree BEFORE UPDATE ON tree FOR EACH ROW EXECUTE PROCEDURE fbu_tree();
