-- Вставка нового элемента

-- Данные элемента
SET @header = :header;
-- Указываем родителя
SET @parentId = :pid;

-- Вставляем данные
INSERT INTO tree.ct_tree (pid, header)
VALUES (@parentId, @header);

-- Определяем id нового элемента
SET @lastID := LAST_INSERT_ID();
-- Вставляем связи
INSERT INTO tree.ct_tree_rel (aid, did)
	-- Выбираем всех родителей (did = id нашего предока)
	-- и вставляем записи типа: idПредка, нашId
	SELECT
		aid, @lastID
	FROM
		tree.ct_tree_rel
    WHERE
		did = @parentId
--     UNION ALL
--     SELECT @lastID, @lastID