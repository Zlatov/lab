DROP TABLE IF EXISTS `tree_rel`;
DROP TABLE IF EXISTS `tree`;

CREATE TABLE IF NOT EXISTS `tree` (
  `id` INT unsigned NOT NULL AUTO_INCREMENT,
  `pid` INT unsigned NULL DEFAULT NULL COMMENT 'Идентификатор предка по Adjacency List.',
  `level` INT unsigned NOT NULL COMMENT 'Уровень элемента начиная с 1, см триггер tbi_tree.',
  `header` VARCHAR(180) NOT NULL,
  `order` INT unsigned NOT NULL DEFAULT 0 COMMENT 'Сортировочное значение.',
  PRIMARY KEY (`id`),
  INDEX `ix_tree_pid` (`pid`) COMMENT 'Индекс для поиска по идентификатору предка.',
  INDEX `ix_tree_order` (`order`) COMMENT 'Индекс для сортировки по значению.',
  INDEX `ix_tree_level` (`level`) COMMENT 'Индекс для поиска по уровню.',
  -- При удалении родителя элемент удаляется автоматически.
  CONSTRAINT `fk_tree_pid` FOREIGN KEY (`pid`) REFERENCES `tree` (`id`) ON UPDATE CASCADE ON DELETE CASCADE
)
ENGINE InnoDB
AUTO_INCREMENT 1
DEFAULT CHARACTER SET utf8
COLLATE utf8_general_ci;

-- ALTER TABLE `tree`
--   ADD CONSTRAINT `fk_tree_pid` FOREIGN KEY (`pid`) REFERENCES `tree` (`id`) ON UPDATE CASCADE ON DELETE CASCADE;

CREATE TABLE IF NOT EXISTS `tree_rel` (
  `aid` INT unsigned NOT NULL COMMENT 'aid - (a - ancestor) идентификатор предка.',
  `did` INT unsigned NOT NULL COMMENT 'did - (d - descendant) идентификатор потомка.',
  UNIQUE KEY `uq_tree_rel_aiddid` (`aid` ASC, `did` ASC),
  INDEX `ix_treerel_aid` (`aid`),
  INDEX `ix_treerel_did` (`did`),
  -- При удалении элемента его связи на потомков удаляются автоматически.
  CONSTRAINT `fk_treerel_aid` FOREIGN KEY (`aid`) REFERENCES `tree` (`id`) ON UPDATE CASCADE ON DELETE CASCADE,
  -- При удалении элемента его связи на предков удаляются автоматически.
  CONSTRAINT `fk_treerel_did` FOREIGN KEY (`did`) REFERENCES `tree` (`id`) ON UPDATE CASCADE ON DELETE CASCADE
)
ENGINE InnoDB
DEFAULT CHARACTER SET utf8
COLLATE utf8_general_ci;
