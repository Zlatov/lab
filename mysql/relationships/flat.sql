DROP TABLE IF EXISTS `clients`;

CREATE TABLE `clients` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `name` VARCHAR(255) NOT NULL,
  `updated_at` TIMESTAMP NULL,
  `note` TEXT CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `description` MEDIUMTEXT CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `clients_name` (`name`)
)
ENGINE=InnoDB
AUTO_INCREMENT 1
DEFAULT CHARSET=utf8
COLLATE utf8_general_ci
COMMENT 'Файлы';

INSERT INTO `clients`
  (`name`)
VALUES
  ('Вася'),
  ('ООО Рога');

DELETE 
FROM `clients`
WHERE `name` = 'Вася';

UPDATE `clients`
SET `note` = 'new'
WHERE id = 2;

SELECT * FROM `clients`;
