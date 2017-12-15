DROP TABLE IF EXISTS `seo`;


-- 1. title (с подсветкой длины 20-80 символов)
-- 2. Description (с подсветкой длины 140–180 символов)
-- 3. keywords
-- 4. Контент (тело): описание, картинки
-- 5. Заголовок H1
-- 6. Атрибуты (просмотр)
-- 7. URL
CREATE TABLE `seo` (
  `id` VARCHAR(12) NOT NULL,
  `title` VARCHAR(255) NULL,
  `description` VARCHAR(511) NULL,
  `keywords` VARCHAR(255) NULL,
  `h1` VARCHAR(255) NULL,
  PRIMARY KEY (`id`)
)
ENGINE=InnoDB
DEFAULT CHARSET=utf8
COLLATE utf8_general_ci
COMMENT 'Таблица сео параметров';
