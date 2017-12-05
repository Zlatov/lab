-- Удаляем таблицу если есть.
DROP TABLE IF EXISTS `file`;

-- Создаём таблицу file
CREATE TABLE `file` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `sid` VARCHAR(160) NOT NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `header` VARCHAR(255) NOT NULL,

  `updated_at` TIMESTAMP NULL,
  `introtext` TEXT CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `text` MEDIUMTEXT CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `title` VARCHAR(160) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `description` VARCHAR(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `keywords` VARCHAR(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,

  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_sid` (`sid`)
)
ENGINE=InnoDB
AUTO_INCREMENT 1
DEFAULT CHARSET=utf8
COLLATE utf8_general_ci
COMMENT 'Файлы';

INSERT INTO `file` (`sid`, `header`)
VALUES ('1', '1'),
('2', '2');

SELECT
	*
FROM
	`file`
