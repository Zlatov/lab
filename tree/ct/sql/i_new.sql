-- Вставка нового элемента

-- Данные элемента
SET @header = 'new1';
-- Указываем родителя
SET @parentId = 4;

-- Вставляем данные
INSERT INTO tree.ct_tree (header)
VALUES (@header);

-- Определяем id нового элемента
SET @lastID := LAST_INSERT_ID();
-- Вставляем связи
INSERT INTO tree.ct_tree_rel (pid, cid)
	-- Выбираем всех родителей
	SELECT pid, @lastID
	FROM tree.ct_tree_rel
    WHERE cid = @parentId
    UNION ALL
    SELECT @lastID, @lastID