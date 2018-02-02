DROP TABLE IF EXISTS `orders`;
DROP TABLE IF EXISTS `customers`;

CREATE TABLE `customers` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(160) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_customers_name` (`name`)
)
ENGINE=InnoDB
AUTO_INCREMENT 1
DEFAULT CHARSET=utf8
COLLATE utf8_general_ci
COMMENT 'Покупатели';

CREATE TABLE `orders` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `customer_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_orders_customerid` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`) ON UPDATE CASCADE ON DELETE CASCADE
)
ENGINE=InnoDB
AUTO_INCREMENT 1
DEFAULT CHARSET=utf8
COLLATE utf8_general_ci
COMMENT 'Заказы';


INSERT INTO `customers`
  (`name`)
VALUES
  ('Петя'),
  ('Вася'),
  ('Коля');

INSERT INTO `orders`
  (`customer_id`)
VALUES
  (1),
  (1),
  (2),
  (3);

SELECT
  *
FROM `customers` `c`
LEFT JOIN `orders` `o` on `o`.`customer_id` = `c`.`id`;
