-- Удаляем таблицы если есть.
DROP TABLE IF EXISTS `file`;
DROP TABLE IF EXISTS `folder`;

-- Создаём таблицу folder
CREATE TABLE `folder` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

  `sid` VARCHAR(160) NOT NULL,
  `header` VARCHAR(255) NOT NULL,

  `updated_at` TIMESTAMP NULL,
  `introtext` TEXT CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `text` MEDIUMTEXT CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `title` VARCHAR(160) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `description` VARCHAR(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `keywords` VARCHAR(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,

  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_folder_sid` (`sid`)
)
ENGINE=InnoDB
AUTO_INCREMENT 1
DEFAULT CHARSET=utf8
COLLATE utf8_general_ci
COMMENT 'Папки';

-- Создаём таблицу file
CREATE TABLE `file` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

  `folder_id` INT UNSIGNED NOT NULL,
  `sid` VARCHAR(160) NOT NULL,
  `header` VARCHAR(255) NOT NULL,

  `updated_at` TIMESTAMP NULL,
  `introtext` TEXT CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `text` MEDIUMTEXT CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `title` VARCHAR(160) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `description` VARCHAR(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `keywords` VARCHAR(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,


  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_file_sid` (`sid`),
  CONSTRAINT `fk_file_folderid` FOREIGN KEY (`folder_id`) REFERENCES `folder` (`id`) ON UPDATE CASCADE ON DELETE CASCADE
)
ENGINE=InnoDB
AUTO_INCREMENT 1
DEFAULT CHARSET=utf8
COLLATE utf8_general_ci
COMMENT 'Файлы';


INSERT INTO `folder`
  (`sid`, `header`)
VALUES
  ('1', '1'),
  ('2', '2');

INSERT INTO `file`
  (`folder_id`, `sid`, `header`)
VALUES
  (1, '1', '1'),
  (2, '2', '2');

DELETE 
FROM `file`
WHERE `sid` = '1';

UPDATE `file`
SET `sid` = '3', `header` = '3'
WHERE id = 2;

SELECT * FROM `folder`;
SELECT * FROM `file`;
