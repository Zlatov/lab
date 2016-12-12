-- USE `treect2`;
DROP TABLE IF EXISTS `treerel`;
DROP TABLE IF EXISTS `tree`;
CREATE TABLE IF NOT EXISTS `tree` (
  `id` INT unsigned NOT NULL AUTO_INCREMENT,
  `pid` INT unsigned NULL DEFAULT NULL,
  `header` VARCHAR(180) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_tree_header` (`header` ASC)
)
ENGINE InnoDB
AUTO_INCREMENT 1
DEFAULT CHARACTER SET utf8
COLLATE utf8_general_ci;

ALTER TABLE `tree`
  ADD CONSTRAINT `fk_tree_pid` FOREIGN KEY (`pid`) REFERENCES `tree` (`id`) ON UPDATE CASCADE ON DELETE RESTRICT;

CREATE TABLE IF NOT EXISTS `treerel` (
  `aid` INT unsigned NOT NULL,
  `did` INT unsigned NOT NULL,
  -- `level` INT unsigned NOT NULL,
  UNIQUE KEY `uq_treerel_adid` (`aid` ASC, `did` ASC),
  CONSTRAINT `fk_treerel_aid` FOREIGN KEY (`aid`) REFERENCES `tree` (`id`) ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT `fk_treerel_did` FOREIGN KEY (`did`) REFERENCES `tree` (`id`) ON UPDATE CASCADE ON DELETE RESTRICT
)
ENGINE InnoDB
DEFAULT CHARACTER SET utf8
COLLATE utf8_general_ci;
