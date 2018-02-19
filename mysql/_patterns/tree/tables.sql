DROP TABLE IF EXISTS `categories_rels`;
DROP TABLE IF EXISTS `categories`;

CREATE TABLE `categories` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `pid` INT UNSIGNED NULL DEFAULT NULL,
  `level` INT UNSIGNED NOT NULL,
  `name` VARCHAR(255) NOT NULL,
  `order` INT UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_categories_pid` FOREIGN KEY (`pid`) REFERENCES `categories` (`id`) ON UPDATE CASCADE ON DELETE CASCADE
)
ENGINE InnoDB
AUTO_INCREMENT 1
DEFAULT CHARACTER SET utf8
COLLATE utf8_general_ci
COMMENT 'Категории';

CREATE TABLE IF NOT EXISTS `categories_rels` (
  `aid` INT UNSIGNED NOT NULL,
  `did` INT UNSIGNED NOT NULL,
  UNIQUE KEY `uq_categoriesrels_adid` (`aid` ASC, `did` ASC),
  CONSTRAINT `fk_categoriesrels_aid` FOREIGN KEY (`aid`) REFERENCES `categories` (`id`) ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT `fk_categoriesrels_did` FOREIGN KEY (`did`) REFERENCES `categories` (`id`) ON UPDATE CASCADE ON DELETE CASCADE
)
ENGINE InnoDB
DEFAULT CHARACTER SET utf8
COLLATE utf8_general_ci
COMMENT 'Связи категорий';
